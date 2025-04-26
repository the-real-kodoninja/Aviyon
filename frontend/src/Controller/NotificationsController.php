<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class NotificationsController extends AbstractController
{
    #[Route('/notifications', name: 'notifications')]
    public function index(): Response
    {
        return $this->render('pages/notifications.html.twig');
    }
}
