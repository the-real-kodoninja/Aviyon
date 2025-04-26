<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class AgentController extends AbstractController
{
    #[Route('/dashboard/agent/create', name: 'agent_create', methods: ['POST'])]
    public function create(Request $request): Response
    {
        return $this->redirectToRoute('dashboard_agents');
    }

    #[Route('/dashboard/agent/{id}/edit', name: 'agent_edit')]
    public function edit(string $id): Response
    {
        return $this->render('dashboard/agent_edit.html.twig', ['id' => $id]);
    }

    #[Route('/dashboard/agent/delete', name: 'agent_delete', methods: ['POST'])]
    public function delete(Request $request): Response
    {
        return $this->redirectToRoute('dashboard_agents');
    }
}
