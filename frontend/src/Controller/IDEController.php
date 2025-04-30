<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\Process\Process;
use Symfony\Component\Routing\Annotation\Route;

class IDEController extends AbstractController
{
    #[Route('/np-plus-plus/{workspace}', name: 'np_plus_plus', defaults: ['workspace' => null])]
    public function openNimbusPad(?string $workspace = null): Response
    {
        // Path to the Nimbuspad++ directory
        $nimbusPadDir = $this->getParameter('kernel.project_dir') . '/nimbuspad-plus-plus';

        // Check if the Nimbuspad++ server is running (on port 3000 by default, based on package.json start script)
        $checkProcess = new Process(['lsof', '-i', ':3000']);
        $checkProcess->run();

        if (!$checkProcess->isSuccessful() || empty($checkProcess->getOutput())) {
            // Start the Nimbuspad++ server if it's not running
            $process = new Process(['npm', 'start'], $nimbusPadDir);
            $process->start();

            // Wait briefly to ensure the server starts
            sleep(2);
        }

        // Base URL for Nimbuspad++
        $nimbusPadUrl = 'http://localhost:3000';

        // If a workspace is specified, append it to the URL as a query parameter
        if ($workspace) {
            $nimbusPadUrl .= '?workspace=' . urlencode($workspace);
        }

        // Return a JavaScript response to open the URL in a new tab
        $script = <<<JS
<script>
    window.open('$nimbusPadUrl', '_blank');
    window.location.href = '/dashboard';
</script>
JS;

        return new Response($script);
    }
}
