document.addEventListener('DOMContentLoaded', () => {
  const docContent = document.getElementById('doc-content');

  async function loadMarkdown(file) {
    console.log(`Attempting to load Markdown file: /docs/${file}`);
    try {
      const response = await fetch(`/docs/${file}`);
      console.log(`Fetch response status: ${response.status}`);
      if (!response.ok) {
        throw new Error(`Failed to load Markdown file: ${response.statusText}`);
      }
      const markdown = await response.text();
      console.log(`Markdown content received: ${markdown.substring(0, 100)}...`);
      const html = marked.parse(markdown, {
        baseUrl: `/docs/${file.substring(0, file.lastIndexOf('/'))}/`,
        breaks: true,
        gfm: true
      });
      docContent.innerHTML = html;
    } catch (error) {
      console.error('Error loading Markdown:', error);
      docContent.innerHTML = `<p class="text-red-500">Failed to load documentation. Error: ${error.message}</p>`;
    }
  }

  const firstLink = document.querySelector('.doc-link');
  if (firstLink) {
    console.log(`First link found, loading: ${firstLink.dataset.mdFile}`);
    loadMarkdown(firstLink.dataset.mdFile);
  } else {
    console.log('No doc-link found');
  }
});
