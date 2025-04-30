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

    #[Route('/admin/platforms', name: 'admin_manage_platforms')]
    public function managePlatforms(): Response
    {
        return $this->render('admin/manage_platforms.html.twig');
    }

    #[Route('/admin/users', name: 'admin_manage_users')]
    public function manageUsers(): Response
    {
        return $this->render('admin/manage_users.html.twig');
    }

    #[Route('/admin/reports', name: 'admin_manage_reports')]
    public function manageReports(): Response
    {
        return $this->render('admin/manage_reports.html.twig');
    }

    #[Route('/admin/platform/delete', name: 'admin_platform_delete', methods: ['POST'])]
    public function deletePlatform(Request $request): Response
    {
        return $this->redirectToRoute('admin_manage_platforms');
    }

    #[Route('/admin/user/delete', name: 'admin_user_delete', methods: ['POST'])]
    public function deleteUser(Request $request): Response
    {
        return $this->redirectToRoute('admin_manage_users');
    }

    #[Route('/admin/report/{id}/view', name: 'admin_report_view')]
    public function viewReport(string $id): Response
    {
        return $this->render('admin/report_view.html.twig', ['id' => $id]);
    }

    #[Route('/admin/report/dismiss', name: 'admin_report_dismiss', methods: ['POST'])]
    public function dismissReport(Request $request): Response
    {
        return $this->redirectToRoute('admin_manage_reports');
    }

    #[Route('/admin/report/remove-content', name: 'admin_report_remove_content', methods: ['POST'])]
    public function removeContent(Request $request): Response
    {
        return $this->redirectToRoute('admin_manage_reports');
    }

    #[Route('/admin/settings/save', name: 'admin_settings_save', methods: ['POST'])]
    public function saveSettings(Request $request): Response
    {
        return $this->redirectToRoute('admin');
    }
}
