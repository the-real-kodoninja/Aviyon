<?php

namespace App\Controller\Header;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class NotificationsController extends AbstractController
{
    #[Route('/header/notifications', name: 'header_notifications')]
    public function index(): Response
    {
        // In a real application, this would fetch notifications from a database
        return $this->render('components/header/notifications.html.twig');
    }
}
