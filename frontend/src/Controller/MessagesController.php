<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Psr\Log\LoggerInterface;

class MessagesController extends AbstractController
{
    private $logger;

    public function __construct(LoggerInterface $logger)
    {
        $this->logger = $logger;
    }

    #[Route('/messages', name: 'app_messages')]
    public function index(): Response
    {
        $this->logger->info('Accessed Messages page');
        return $this->render('pages/messages.html.twig');
    }

    #[Route('/api/messages/send', name: 'api_messages_send', methods: ['POST'])]
    public function sendMessage(Request $request): Response
    {
        $data = json_decode($request->getContent(), true);
        $sender = $data['sender'] ?? 'User';
        $receiver = $data['receiver'] ?? 'Nimbus AI';
        $message = $data['message'] ?? '';

        if (!$message) {
            return $this->json(['error' => 'Message is required'], 400);
        }

        $this->logger->info("Message sent from {$sender} to {$receiver}: {$message}");
        $response = $receiver === 'Nimbus AI' && strpos(strtolower($message), 'help') !== false
            ? 'I can assist with coding, analytics, or virtual world navigation. What do you need?'
            : 'Message received! How can I assist?';

        return $this->json(['status' => 'success', 'response' => $response]);
    }

    #[Route('/api/messages/history', name: 'api_messages_history', methods: ['POST'])]
    public function getHistory(Request $request): Response
    {
        $data = json_decode($request->getContent(), true);
        $contact = $data['contact'] ?? 'Nimbus AI';

        $this->logger->info("Fetching history for {$contact}");
        $history = [
            ['sender' => 'Nimbus AI', 'content' => 'Hello! How can I assist you today?', 'time' => '10:30 AM, May 5, 2025'],
            ['sender' => 'You', 'content' => 'Can you help me with a coding project?', 'time' => '10:32 AM, May 5, 2025']
        ];

        return $this->json(['status' => 'success', 'messages' => $history]);
    }

    #[Route('/api/settings/theme', name: 'api_settings_theme', methods: ['POST'])]
    public function setTheme(Request $request): Response
    {
        $data = json_decode($request->getContent(), true);
        $theme = $data['theme'] ?? 'dark';
        $user = $data['user'] ?? 'anonymous';

        $this->logger->info("Theme set to {$theme} for user {$user}");
        return $this->json(['status' => 'success', 'theme' => $theme]);
    }
}
