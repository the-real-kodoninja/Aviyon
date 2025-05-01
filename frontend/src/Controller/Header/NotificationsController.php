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
        // This controller might be used for the header dropdown
        return $this->render('components/header/notifications.html.twig');
    }

    #[Route('/notifications', name: 'notifications')]
    public function dashboardNotifications(): Response
    {
        // In a real application, this would fetch notifications from a database
        $notifications = [
            [
                'id' => 1,
                'title' => 'New Follower',
                'message' => 'Ninja followed you!',
                'timestamp' => '2025-05-01 10:00:00',
            ],
            [
                'id' => 2,
                'title' => 'Post Liked',
                'message' => 'Kodo liked your post: "Just launched my new project in the Kodoverse!"',
                'timestamp' => '2025-05-01 09:30:00',
            ],
        ];

        return $this->render('dashboard/notifications.html.twig', [
            'notifications' => $notifications,
        ]);
    }

    #[Route('/notifications/mark-as-read/{id}', name: 'mark_notification_as_read', methods: ['POST'])]
    public function markAsRead(int $id): Response
    {
        // In a real application, this would update the notification status in the database
        return new Response(null, 200);
    }
}
