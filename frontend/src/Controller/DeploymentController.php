<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class DeploymentController extends AbstractController
{
    #[Route('/dashboard/deploy', name: 'deploy_app', methods: ['POST'])]
    public function deploy(Request $request): Response
    {
        return $this->redirectToRoute('dashboard_deployments');
    }

    #[Route('/dashboard/deployment/{id}/logs', name: 'deployment_logs')]
    public function viewLogs(string $id): Response
    {
        return $this->render('dashboard/deployment_logs.html.twig', ['id' => $id]);
    }

    #[Route('/dashboard/deployment/restart', name: 'deployment_restart', methods: ['POST'])]
    public function restart(Request $request): Response
    {
        return $this->redirectToRoute('dashboard_deployments');
    }

    #[Route('/dashboard/deployment/delete', name: 'deployment_delete', methods: ['POST'])]
    public function delete(Request $request): Response
    {
        return $this->redirectToRoute('dashboard_deployments');
    }
}
