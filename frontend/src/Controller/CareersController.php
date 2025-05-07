<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\File\Exception\FileException;

class CareersController extends AbstractController
{
    #[Route('/careers', name: 'careers')]
    public function index(): Response
    {
        return $this->render('pages/careers.html.twig');
    }

    #[Route('/careers/job/{id}', name: 'careers_job', requirements: ['id' => '\d+'])]
    public function job(int $id): Response
    {
        $jobs = [
            1 => [
                'id' => 1,
                'title' => 'CEO, KodoFilms Studios',
                'company' => 'KodoFilms Studios',
                'description' => 'Lead 20+ production companies and KDN+ streaming. 15+ years in film leadership.',
                'location' => 'KodoCity, TX',
                'department' => 'Executive Leadership',
                'requirements' => '15+ years in film leadership, proven track record in managing large-scale production teams.'
            ],
            2 => [
                'id' => 2,
                'title' => 'CTO, Aviyon Advanced Technology',
                'company' => 'Aviyon Advanced Technology',
                'description' => 'Drive robotics and brain-computer interface innovation. 10+ years in AI/tech leadership.',
                'location' => 'Remote',
                'department' => 'Executive Leadership',
                'requirements' => '10+ years in AI/tech leadership, experience with robotics and neural interfaces.'
            ],
            3 => [
                'id' => 3,
                'title' => 'Senior AI Engineer, nimbus.ai',
                'company' => 'nimbus.ai',
                'description' => 'Develop ASI/AGI models with Python/Rust. 7+ years in ML.',
                'location' => 'Remote',
                'department' => 'Technology & Development',
                'requirements' => '7+ years in machine learning, proficiency in Python and Rust.'
            ],
            4 => [
                'id' => 4,
                'title' => 'VR Developer, Velocity Corporation',
                'company' => 'Velocity Corporation',
                'description' => 'Build VR for Velocity Esports. 5+ years in VR dev with Three.js.',
                'location' => 'Remote',
                'department' => 'Technology & Development',
                'requirements' => '5+ years in VR development, expertise in Three.js and WebGL.'
            ],
            5 => [
                'id' => 5,
                'title' => 'Film Producer, KodoFilms Studios',
                'company' => 'KodoFilms Studios',
                'description' => 'Produce blockbusters and animations. 8+ years in film production.',
                'location' => 'Los Angeles, CA',
                'department' => 'Creative & Media',
                'requirements' => '8+ years in film production, experience with blockbuster films.'
            ],
            6 => [
                'id' => 6,
                'title' => 'Social Media Manager, Kodoverse',
                'company' => 'Kodoverse',
                'description' => 'Boost kodoanime.social presence. 5+ years in digital marketing.',
                'location' => 'Remote',
                'department' => 'Creative & Media',
                'requirements' => '5+ years in digital marketing, expertise in social media strategies.'
            ],
            7 => [
                'id' => 7,
                'title' => 'Curriculum Developer, KodoAcademy',
                'company' => 'KodoAcademy',
                'description' => 'Design curricula for K-12 and university. 7+ years in education, PhD required.',
                'location' => 'KodoCity, TX',
                'department' => 'Education & Research',
                'requirements' => '7+ years in education, PhD in education or related field.'
            ],
            8 => [
                'id' => 8,
                'title' => 'Project Manager, KodoCity',
                'company' => 'KodoCity',
                'description' => 'Manage a $5B urban project. 10+ years in construction project management.',
                'location' => 'KodoCity, TX',
                'department' => 'Operations & Infrastructure',
                'requirements' => '10+ years in construction project management, experience with large-scale urban projects.'
            ],
        ];

        if (!isset($jobs[$id])) {
            throw $this->createNotFoundException('Job not found');
        }

        return $this->render('components/careers/job_details.html.twig', [
            'job' => $jobs[$id],
            'jobs' => $jobs,
        ]);
    }

    #[Route('/careers/apply/{id}', name: 'careers_apply', requirements: ['id' => '\d+'])]
    public function apply(Request $request, int $id): Response
    {
        $jobs = [
            1 => [
                'id' => 1,
                'title' => 'CEO, KodoFilms Studios',
                'company' => 'KodoFilms Studios',
                'description' => 'Lead 20+ production companies and KDN+ streaming. 15+ years in film leadership.',
                'location' => 'KodoCity, TX',
                'department' => 'Executive Leadership',
                'requirements' => '15+ years in film leadership, proven track record in managing large-scale production teams.'
            ],
            2 => [
                'id' => 2,
                'title' => 'CTO, Aviyon Advanced Technology',
                'company' => 'Aviyon Advanced Technology',
                'description' => 'Drive robotics and brain-computer interface innovation. 10+ years in AI/tech leadership.',
                'location' => 'Remote',
                'department' => 'Executive Leadership',
                'requirements' => '10+ years in AI/tech leadership, experience with robotics and neural interfaces.'
            ],
            3 => [
                'id' => 3,
                'title' => 'Senior AI Engineer, nimbus.ai',
                'company' => 'nimbus.ai',
                'description' => 'Develop ASI/AGI models with Python/Rust. 7+ years in ML.',
                'location' => 'Remote',
                'department' => 'Technology & Development',
                'requirements' => '7+ years in machine learning, proficiency in Python and Rust.'
            ],
            4 => [
                'id' => 4,
                'title' => 'VR Developer, Velocity Corporation',
                'company' => 'Velocity Corporation',
                'description' => 'Build VR for Velocity Esports. 5+ years in VR dev with Three.js.',
                'location' => 'Remote',
                'department' => 'Technology & Development',
                'requirements' => '5+ years in VR development, expertise in Three.js and WebGL.'
            ],
            5 => [
                'id' => 5,
                'title' => 'Film Producer, KodoFilms Studios',
                'company' => 'KodoFilms Studios',
                'description' => 'Produce blockbusters and animations. 8+ years in film production.',
                'location' => 'Los Angeles, CA',
                'department' => 'Creative & Media',
                'requirements' => '8+ years in film production, experience with blockbuster films.'
            ],
            6 => [
                'id' => 6,
                'title' => 'Social Media Manager, Kodoverse',
                'company' => 'Kodoverse',
                'description' => 'Boost kodoanime.social presence. 5+ years in digital marketing.',
                'location' => 'Remote',
                'department' => 'Creative & Media',
                'requirements' => '5+ years in digital marketing, expertise in social media strategies.'
            ],
            7 => [
                'id' => 7,
                'title' => 'Curriculum Developer, KodoAcademy',
                'company' => 'KodoAcademy',
                'description' => 'Design curricula for K-12 and university. 7+ years in education, PhD required.',
                'location' => 'KodoCity, TX',
                'department' => 'Education & Research',
                'requirements' => '7+ years in education, PhD in education or related field.'
            ],
            8 => [
                'id' => 8,
                'title' => 'Project Manager, KodoCity',
                'company' => 'KodoCity',
                'description' => 'Manage a $5B urban project. 10+ years in construction project management.',
                'location' => 'KodoCity, TX',
                'department' => 'Operations & Infrastructure',
                'requirements' => '10+ years in construction project management, experience with large-scale urban projects.'
            ],
        ];

        if (!isset($jobs[$id])) {
            throw $this->createNotFoundException('Job not found');
        }

        return $this->render('components/careers/application_form.html.twig', [
            'job' => $jobs[$id],
            'jobs' => $jobs,
        ]);
    }

    #[Route('/careers/submit-application', name: 'careers_submit_application', methods: ['POST'])]
    public function submitApplication(Request $request): Response
    {
        // Extract form fields
        $name = $request->request->get('name');
        $email = $request->request->get('email');
        $position = $request->request->get('position');
        $coverLetterFile = $request->files->get('cover_letter');
        $resumeFile = $request->files->get('resume_file');
        $noCoverLetter = $request->request->get('no_cover_letter') === 'on';
        $coverLetterInResume = $request->request->get('cover_letter_in_resume') === 'on';
        $video = $request->request->get('video');
        $portfolio = $request->request->get('portfolio');
        $linkedin = $request->request->get('linkedin');
        $github = $request->request->get('github');
        $assessment = $request->request->get('assessment');
        $favoriteProduct = $request->request->get('favorite_product');
        $hasNimbusAgent = $request->request->get('has_nimbus_agent');
        $nimbusAgentId = $request->request->get('nimbus_agent_id');
        $hearAbout = $request->request->get('hear_about');
        $knowAbout = $request->request->get('know_about');
        $careerGoals = $request->request->get('career_goals');
        $availability = $request->request->get('availability');
        $workSetup = $request->request->get('work_setup');

        // Validate required fields
        if (!$name || !$email || !$position || !$resumeFile || !$assessment || !$favoriteProduct || !$hearAbout || !$knowAbout || !$careerGoals || !$availability || !$workSetup) {
            $this->addFlash('error', 'Please fill in all required fields.');
            return $this->redirectToRoute('careers_apply', ['id' => $position]);
        }

        // Handle file uploads
        $uploadDirectory = $this->getParameter('kernel.project_dir') . '/public/uploads/applications';
        if (!is_dir($uploadDirectory)) {
            mkdir($uploadDirectory, 0777, true);
        }

        $applicationId = uniqid('app_', true);

        // Handle cover letter upload
        $coverLetterPath = null;
        if ($coverLetterFile && !$noCoverLetter && !$coverLetterInResume) {
            $originalFilename = pathinfo($coverLetterFile->getClientOriginalName(), PATHINFO_FILENAME);
            $safeFilename = preg_replace('/[^a-z0-9-_]/', '_', strtolower($originalFilename));
            $newFilename = $safeFilename . '-' . $applicationId . '.' . $coverLetterFile->guessExtension();

            try {
                $coverLetterFile->move($uploadDirectory, $newFilename);
                $coverLetterPath = '/uploads/applications/' . $newFilename;
            } catch (FileException $e) {
                $this->addFlash('error', 'Failed to upload cover letter: ' . $e->getMessage());
                return $this->redirectToRoute('careers_apply', ['id' => $position]);
            }
        }

        // Handle resume upload
        $resumePath = null;
        if ($resumeFile) {
            $originalFilename = pathinfo($resumeFile->getClientOriginalName(), PATHINFO_FILENAME);
            $safeFilename = preg_replace('/[^a-z0-9-_]/', '_', strtolower($originalFilename));
            $newFilename = $safeFilename . '-' . $applicationId . '.' . $resumeFile->guessExtension();

            try {
                $resumeFile->move($uploadDirectory, $newFilename);
                $resumePath = '/uploads/applications/' . $newFilename;
            } catch (FileException $e) {
                $this->addFlash('error', 'Failed to upload resume: ' . $e->getMessage());
                return $this->redirectToRoute('careers_apply', ['id' => $position]);
            }
        }

        // Simulate resume parsing for autofill (mock data)
        $autofillData = [
            'name' => $name,
            'email' => $email,
            'skills' => 'Python, JavaScript, Leadership', // Mock extracted skills
        ];

        // Validate Nimbus Agent ID if applicable
        if ($hasNimbusAgent === 'yes' && empty($nimbusAgentId)) {
            $this->addFlash('error', 'Please provide your Nimbus Agent ID.');
            return $this->redirectToRoute('careers_apply', ['id' => $position]);
        }

        // Prepare application data (in a real app, save to database)
        $applicationData = [
            'name' => $name,
            'email' => $email,
            'position' => $position,
            'cover_letter_path' => $coverLetterPath,
            'resume_path' => $resumePath,
            'no_cover_letter' => $noCoverLetter,
            'cover_letter_in_resume' => $coverLetterInResume,
            'video' => $video,
            'portfolio' => $portfolio,
            'linkedin' => $linkedin,
            'github' => $github,
            'assessment' => $assessment,
            'favorite_product' => $favoriteProduct,
            'has_nimbus_agent' => $hasNimbusAgent,
            'nimbus_agent_id' => $nimbusAgentId,
            'hear_about' => $hearAbout,
            'know_about' => $knowAbout,
            'career_goals' => $careerGoals,
            'availability' => $availability,
            'work_setup' => $workSetup,
            'autofill_data' => $autofillData,
        ];

        // Log the application data (in a real app, save to database)
        $logFile = $this->getParameter('kernel.project_dir') . '/var/log/applications.log';
        file_put_contents($logFile, json_encode($applicationData) . "\n", FILE_APPEND);

        $this->addFlash('success', 'Application submitted successfully! We will review your submission.');
        return $this->redirectToRoute('careers');
    }

    #[Route('/careers/explore', name: 'careers_explore')]
    public function explore(): Response
    {
        return $this->render('components/careers/explore.html.twig');
    }
}
