<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

class HostingController extends AbstractController
{
    #[Route('/hosting/{domain}', name: 'hosting', defaults: ['domain' => null])]
    public function hosting(?string $domain): Response
    {
        // For new users selecting a domain and hosting plan
        return $this->render('pages/hosting.html.twig', [
            'domain' => $domain ?? 'yourdomain.aviyon.com',
        ]);
    }

    #[Route('/dashboard/hosting/{domain}', name: 'dashboard_hosting', defaults: ['domain' => null])]
    #[IsGranted('IS_AUTHENTICATED_FULLY')]
    public function dashboardHosting(?string $domain): Response
    {
        // For logged-in users managing their hosting
        if (!$this->isGranted('IS_AUTHENTICATED_FULLY')) {
            return $this->redirectToRoute('domain');
        }
        return $this->render('dashboard/hosting.html.twig', [
            'domain' => $domain ?? $this->getUser()->getDomain() ?? 'yourdomain.aviyon.com',
        ]);
    }

    #[Route('/hosting/select-plan/{plan}/{domain}', name: 'hosting_select_plan', defaults: ['domain' => null])]
    public function selectPlan(string $plan, ?string $domain): Response
    {
        // Logic for selecting a hosting plan
        return $this->render('pages/hosting_plan.html.twig', [
            'plan' => $plan,
            'domain' => $domain ?? 'yourdomain.aviyon.com',
        ]);
    }

    #[Route('/hosting/analytics', name: 'resource_analytics')]
    public function analytics(): Response
    {
        return $this->render('dashboard/hosting_analytics.html.twig');
    }

    #[Route('/hosting/quick-deploy', name: 'quick_deploy', methods: ['POST'])]
    public function quickDeploy(Request $request): Response
    {
        $projectName = $request->request->get('project_name');
        $domain = $request->request->get('domain');
        // Add logic to deploy the project
        $this->addFlash('success', "Project '$projectName' deployed successfully on '$domain'!");
        if ($this->isGranted('IS_AUTHENTICATED_FULLY')) {
            return $this->redirectToRoute('dashboard_hosting', ['domain' => $domain]);
        }
        return $this->redirectToRoute('hosting', ['domain' => $domain]);
    }
}
