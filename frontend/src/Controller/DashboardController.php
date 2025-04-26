<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class DashboardController extends AbstractController
{
    #[Route('/dashboard', name: 'dashboard')]
    public function index(): Response
    {
        return $this->render('dashboard/index.html.twig');
    }

    #[Route('/dashboard/deployments', name: 'dashboard_deployments')]
    public function deployments(): Response
    {
        return $this->render('dashboard/deployments.html.twig');
    }

    #[Route('/dashboard/hosting', name: 'dashboard_hosting')]
    public function hosting(): Response
    {
        return $this->render('dashboard/hosting.html.twig');
    }

    #[Route('/dashboard/agents', name: 'dashboard_agents')]
    public function agents(): Response
    {
        return $this->render('dashboard/agents.html.twig');
    }

    #[Route('/dashboard/virtual-world', name: 'dashboard_virtual_world')]
    public function virtualWorld(): Response
    {
        return $this->render('dashboard/virtual-world.html.twig');
    }

    #[Route('/dashboard/messages', name: 'dashboard_messages')]
    public function messages(): Response
    {
        return $this->render('dashboard/messages.html.twig');
    }

    #[Route('/dashboard/nimbus-ai', name: 'dashboard_nimbus_ai')]
    public function nimbusAi(): Response
    {
        return $this->render('dashboard/nimbus-ai.html.twig');
    }

    #[Route('/dashboard/marketplace', name: 'marketplace')]
    public function marketplace(): Response
    {
        return $this->render('dashboard/marketplace.html.twig');
    }
}
