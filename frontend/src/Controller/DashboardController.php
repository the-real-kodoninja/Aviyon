<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;

class DashboardController extends AbstractController
{
    public function index(): Response
    {
        return $this->render('dashboard/index.html.twig');
    }

    public function ide(): Response
    {
        return $this->render('dashboard/ide.html.twig');
    }

    public function deployments(): Response
    {
        return $this->render('dashboard/deployments.html.twig');
    }

    public function hosting(): Response
    {
        return $this->render('dashboard/hosting.html.twig');
    }

    public function agents(): Response
    {
        return $this->render('dashboard/agents.html.twig');
    }

    public function marketplace(): Response
    {
        return $this->render('dashboard/marketplace.html.twig');
    }

    public function virtualWorld(): Response
    {
        return $this->render('dashboard/virtual-world.html.twig');
    }

    public function messages(): Response
    {
        return $this->render('dashboard/messages.html.twig');
    }

    public function nimbusAi(): Response
    {
        return $this->render('dashboard/nimbus-ai.html.twig');
    }
}
