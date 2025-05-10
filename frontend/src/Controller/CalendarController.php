<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class CalendarController extends AbstractController
{
    #[Route('/calendar', name: 'calendar')]
    public function index(): Response
    {
        return $this->render('pages/calendar.html.twig');
    }

    #[Route('/calendar/event/{id}', name: 'calendar_event')]
    public function event(int $id): Response
    {
        // Mock event data (replace with database query in production)
        $event = [
            'id' => $id,
            'title' => 'KodoCity Tech Meetup',
            'organizer' => 'Kodoverse Team',
            'start_date' => '2025-05-15 10:00',
            'end_date' => '2025-05-15 12:00',
            'description' => 'Join us for a tech meetup in KodoCity!',
            'media' => 'image',
            'mediaSrc' => '/build/images/tech-meetup.jpg',
            'category' => 'meetups',
            'location' => 'KodoCity',
            'is_live' => false,
        ];

        return $this->render('components/calendar/event_details.html.twig', [
            'event' => $event,
        ]);
    }
}
