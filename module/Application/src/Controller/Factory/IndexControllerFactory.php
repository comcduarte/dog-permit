<?phpnamespace Application\Controller\Factory;use Application\Controller\IndexController;
use Psr\Container\ContainerInterface;
use Laminas\ServiceManager\Factory\FactoryInterface;

class IndexControllerFactory implements FactoryInterface
{
    public function __invoke(ContainerInterface $container, $requestedName, array $options = null)
    {
        $controller = new IndexController();
        $controller->setDbAdapter($container->get('dog-model-primary-adapter'));
        return $controller;
    }
}