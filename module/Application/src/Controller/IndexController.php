<?php
/**
 * @link      http://github.com/zendframework/ZendSkeletonApplication for the canonical source repository
 * @copyright Copyright (c) 2005-2016 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd New BSD License
 */

namespace Application\Controller;

use Dog\Model\OwnerModel;
use Laminas\Db\Adapter\AdapterAwareTrait;
use Laminas\Db\Sql\Where;
use Laminas\Mail\Protocol\Smtp as SmtpProtocol;
use Laminas\Mail\Transport\Smtp as SmtpTransport;
use Laminas\Mime\Mime;
use Laminas\Mvc\Controller\AbstractActionController;
use Laminas\Validator\EmailAddress;
use Laminas\View\Model\ViewModel;
use Laminas\View\Renderer\PhpRenderer;
use Laminas\View\Resolver\AggregateResolver;
use Laminas\View\Resolver\TemplateMapResolver;


class IndexController extends AbstractActionController
{
    use AdapterAwareTrait;
    
    public function indexAction()
    {
        return new ViewModel();
    }
    
    public function emailAction()
    {
        $model = new OwnerModel($this->adapter);
        
        $where = new Where();
        $where->isNotNull('EMAIL');
        
        $owners = $model->fetchAll($where);
        
        $validated_owners = [];
        $validator = new EmailAddress();
        foreach ($owners as $owner) {
            if ($validator->isValid($owner['EMAIL'])) {
                $validated_owners[] = $owner['EMAIL'];
            }
        }
        
//         $validated_owners = [
//             'christopher.duarte@middletownct.gov',
//             'cduarte@dassociatesinc.com',
//         ];
        
        
        $view = new PhpRenderer();
        
        $resolver = new AggregateResolver();
        $view->setResolver($resolver);
        
        $map = new TemplateMapResolver([
            'layout' => __DIR__ . '/../../view/layout/notification.phtml',
            'notifications/renewal' => __DIR__ . '/../../view/notifications/renewal.phtml'
        ]);
        $resolver->attach($map);
        
        $viewModel = new ViewModel();
        $viewModel->setTemplate('notifications/renewal');
        $view->viewModel()->setRoot($viewModel);
        
        $message = new \Laminas\Mail\Message();
        $body = new \Laminas\Mime\Message();
        
        $html = $view->render($viewModel);
        $part = new \Laminas\Mime\Part($html);
        $part->type = Mime::TYPE_HTML;
        
        $message->setFrom('townclerk@middletownct.gov');
        $message->setSubject('Dog Permits - Town Clerks Office');
        
        $body->addPart($part);
        
        $message->setBody($body);
        
        try {
            $protocol = new SmtpProtocol('smtprelay.middletownct.gov');
            $protocol->connect();
            $protocol->helo('dog-permit.middletownct.gov');
            
            $transport = new SmtpTransport();
            $transport->setConnection($protocol);
            $protocol->rset();
            
            foreach ($validated_owners as $email) {
                $message->setTo($email);
                $transport->send($message);
            }
            
            
        } catch (\Exception $e) {
            
        }
        
        $protocol->disconnect();
        return $this->redirect()->toRoute('home');
    }
}
