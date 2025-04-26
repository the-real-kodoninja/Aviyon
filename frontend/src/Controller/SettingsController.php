<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class SettingsController extends AbstractController
{
    #[Route('/settings', name: 'settings')]
    public function index(): Response
    {
        return $this->render('pages/settings.html.twig');
    }

    #[Route('/settings/profile/save', name: 'settings_profile_save', methods: ['POST'])]
    public function saveProfile(Request $request): Response
    {
        return $this->redirectToRoute('settings');
    }

    #[Route('/settings/security/save', name: 'settings_security_save', methods: ['POST'])]
    public function saveSecurity(Request $request): Response
    {
        return $this->redirectToRoute('settings');
    }

    #[Route('/settings/notifications/save', name: 'settings_notifications_save', methods: ['POST'])]
    public function saveNotifications(Request $request): Response
    {
        return $this->redirectToRoute('settings');
    }

    #[Route('/settings/theme/save', name: 'settings_theme_save', methods: ['POST'])]
    public function saveTheme(Request $request): Response
    {
        return $this->redirectToRoute('settings');
    }
}
