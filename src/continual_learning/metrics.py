import torch

from torchmetrics.image.fid import FrechetInceptionDistance
from avalanche.evaluation import Metric, PluginMetric
from avalanche.evaluation.metric_results import MetricValue
from avalanche.evaluation.metric_utils import get_metric_name


# a standalone metric implementation
class FIDMetric(Metric[float]):
    """
    This metric computes the Frechet Inception Distance (FID) between two
    distributions of images. It uses the FID implementation from
    `torchmetrics <https://torchmetrics.readthedocs.io/en/latest/>`_.
    """
    def __init__(self):
        self.reset()

    @torch.no_grad()
    def update(
        self,
        predicted_y: torch.Tensor,
        true_y: torch.Tensor,
    ) -> None:
        true_y = torch.as_tensor(true_y)#.cpu().detach()

        if len(predicted_y) == 3:
            predicted_y = predicted_y[0]

        predicted_y = torch.as_tensor(predicted_y)#.cpu().detach()

        if len(true_y) != len(predicted_y):
            raise ValueError("Size mismatch for true_y and predicted_y tensors")

        if predicted_y.shape[1] == 1:
            predicted_y = torch.cat([predicted_y] * 3, dim=1)
            true_y = torch.cat([true_y] * 3, dim=1)

        self.fid.update(predicted_y, real=False)
        self.fid.update(true_y, real=True)

    def result(self) -> float:
        return self.fid.compute().cpu().detach().item()

    def reset(self):
        self.fid = FrechetInceptionDistance(normalize=True, feature=64)
        self.fid.cuda()


# a standalone metric implementation
class ExperienceFIDMetric(PluginMetric[float]):

    def __init__(self):
        self.fid_metric = FIDMetric()

    def result(self) -> float:
        return self.fid_metric.result()

    def reset(self):
        self.fid_metric.reset()

    def before_training_exp(self, strategy: "SupervisedTemplate") -> None:
        self.train_exp_id = strategy.experience.current_experience

    def after_eval_iteration(self, strategy: 'PluggableStrategy'):
        """
        Update the accuracy metric with the current
        predictions and targets
        """            
        super().after_eval_iteration(strategy)

        if strategy.experience.current_experience > self.train_exp_id:
            return 
        
        self.fid_metric.update(strategy.mb_output, strategy.mb_x)

    def before_eval_exp(self, strategy: 'PluggableStrategy'):
        self.reset()

    def _package_result(self, strategy):
        """Taken from `GenericPluginMetric`, check that class out!"""
        if strategy.experience.current_experience > self.train_exp_id:
            return None
        
        metric_value = self.fid_metric.result()
        add_exp = True
        plot_x_position = strategy.clock.train_iterations

        if isinstance(metric_value, dict):
            metrics = []
            for k, v in metric_value.items():
                metric_name = get_metric_name(
                    self, strategy, add_experience=add_exp, add_task=k)
                metrics.append(MetricValue(self, metric_name, v,
                                           plot_x_position))
            return metrics
        else:
            metric_name = get_metric_name(self, strategy,
                                          add_experience=add_exp,
                                          add_task=True)
            return [MetricValue(self, metric_name, metric_value,
                                plot_x_position)]

    def after_eval_exp(self, strategy: 'PluggableStrategy'):      
        return self._package_result(strategy)
    
    def __str__(self):
        """
        Here you can specify the name of your metric
        """
        return "FID_Experience"