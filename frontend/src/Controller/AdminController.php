<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class AdminController extends AbstractController
{
    #[Route('/admin', name: 'admin')]
    public function index(): Response
    {
        return $this->render('admin/index.html.twig');
    }

    #[Route('/admin/users/new', name: 'admin_users_new')]
    public function newUser(): Response
    {
        return $this->render('admin/user_new.html.twig');
    }

    #[Route('/admin/user/{id}/edit', name: 'admin_user_edit')]
    public function editUser(string $id): Response
    {
        return $this->render('admin/user_edit.html.twig', ['id' => $id]);
    }

    #[Route('/admin/user/delete', name: 'admin_user_delete', methods: ['POST'])]
    public function deleteUser(Request $request): Response
    {
        return $this->redirectToRoute('admin');
    }

    #[Route('/admin/platforms/new', name: 'admin_platforms_new')]
    public function newPlatform(): Response
    {
        return $this->render('admin/platform_new.html.twig');
    }

    #[Route('/admin/platform/{id}/edit', name: 'admin_platform_edit')]
    public function editPlatform(string $id): Response
    {
        return $this->render('admin/platform_edit.html.twig', ['id' => $id]);
    }

    #[Route('/admin/platform/delete', name: 'admin_platform_delete', methods: ['POST'])]
    public function deletePlatform(Request $request): Response
    {
        return $this->redirectToRoute('admin');
    }

    #[Route('/admin/report/{id}/view', name: 'admin_report_view')]
    public function viewReport(string $id): Response
    {
        return $this->render('admin/report_view.html.twig', ['id' => $id]);
    }

    #[Route('/admin/report/dismiss', name: 'admin_report_dismiss', methods: ['POST'])]
    public function dismissReport(Request $request): Response
    {
        return $this->redirectToRoute('admin');
    }

    #[Route('/admin/report/remove-content', name: 'admin_report_remove_content', methods: ['POST'])]
    public function removeContent(Request $request): Response
    {
        return $this->redirectToRoute('admin');
    }

    #[Route('/admin/settings/save', name: 'admin_settings_save', methods: ['POST'])]
    public function saveSettings(Request $request): Response
    {
        return $this->redirectToRoute('admin');
    }
}
