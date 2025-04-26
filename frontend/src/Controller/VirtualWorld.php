<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class VirtualWorldController extends AbstractController
{
    #[Route('/dashboard/virtual-world/enter', name: 'virtual_world_enter')]
    public function enter(): Response
    {
        return $this->render('dashboard/virtual_world_enter.html.twig');
    }

    #[Route('/dashboard/virtual-world/project/{id}', name: 'virtual_world_project')]
    public function viewProject(string $id): Response
    {
        return $this->render('dashboard/virtual_world_project.html.twig', ['id' => $id]);
    }
}
