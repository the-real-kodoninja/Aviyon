<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HostingController extends AbstractController
{
    #[Route('/dashboard/hosting/analytics', name: 'resource_analytics')]
    public function analytics(): Response
    {
        return $this->render('dashboard/hosting_analytics.html.twig');
    }

    #[Route('/dashboard/hosting/quick-deploy', name: 'quick_deploy', methods: ['POST'])]
    public function quickDeploy(Request $request): Response
    {
        return $this->redirectToRoute('dashboard_hosting');
    }
}
