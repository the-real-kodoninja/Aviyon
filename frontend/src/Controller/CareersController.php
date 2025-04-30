<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class CareersController extends AbstractController
{
    #[Route('/careers', name: 'careers')]
    public function index(): Response
    {
        $jobs = [
            [
                'title' => 'Blockchain Developer',
                'department' => 'Engineering',
                'location' => 'Remote',
                'description' => 'Develop and maintain blockchain-based applications for the Kodoverse.',
            ],
            [
                'title' => 'AI Specialist',
                'department' => 'AI Development',
                'location' => 'Remote',
                'description' => 'Enhance Nimbus AI with advanced machine learning capabilities.',
            ],
        ];

        return $this->render('pages/careers.html.twig', [
            'jobs' => $jobs,
        ]);
    }

    #[Route('/careers/apply', name: 'careers_apply', methods: ['POST'])]
    public function apply(Request $request): Response
    {
        return $this->redirectToRoute('careers');
    }
}
