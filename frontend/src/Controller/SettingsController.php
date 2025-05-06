<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Psr\Log\LoggerInterface;

class SettingsController extends AbstractController
{
    private $logger;

    public function __construct(LoggerInterface $logger)
    {
        $this->logger = $logger;
    }

    #[Route('/settings', name: 'app_settings')]
    public function settings(): Response
    {
        $this->logger->info('Accessed Settings page');
        return $this->render('pages/settings.html.twig', [
            'about_text' => 'Unleash the power of communication with Aviyon’s decentralized messaging system. Collaborate on projects, trade NFTs, seek AI assistance from Nimbus AI, or connect with the Kodoverse community—all with end-to-end encryption and real-time sync.'
        ]);
    }
}
