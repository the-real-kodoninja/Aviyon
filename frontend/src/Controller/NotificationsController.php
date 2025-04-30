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
        $notifications = [
            [
                'id' => 1,
                'title' => 'New Message',
                'message' => 'You have a new message from kodonomad.',
                'timestamp' => '2025-04-27 10:00:00',
            ],
            [
                'id' => 2,
                'title' => 'Deployment Successful',
                'message' => 'Your application has been successfully deployed.',
                'timestamp' => '2025-04-27 09:30:00',
            ],
        ];

        return $this->render('pages/notifications.html.twig', [
            'notifications' => $notifications,
        ]);
    }
}
