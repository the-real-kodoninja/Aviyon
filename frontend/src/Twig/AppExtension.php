<?php

namespace App\Twig;

use Twig\Extension\AbstractExtension;
use Twig\TwigFilter;

class AppExtension extends AbstractExtension
{
    public function getFilters(): array
    {
        return [
            new TwigFilter('custom_truncate', [$this, 'truncateText'], ['is_safe' => ['html']]),
        ];
    }

    public function truncateText(string $text, int $length = 150, bool $preserve = true, string $separator = '...'): string
    {
        if (mb_strlen($text) <= $length) {
            return $text;
        }

        $truncated = mb_substr($text, 0, $length);
        if ($preserve) {
            $lastSpace = mb_strrpos($truncated, ' ');
            if ($lastSpace !== false) {
                $truncated = mb_substr($truncated, 0, $lastSpace);
            }
        }

        return $truncated . $separator;
    }
}
