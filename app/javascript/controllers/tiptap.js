import { Editor } from '@tiptap/core';
import StarterKit from '@tiptap/starter-kit';

document.addEventListener('DOMContentLoaded', () => {
  const editorElement = document.querySelector('#editor');

  if (editorElement) {
    const editor = new Editor({
      element: editorElement,
      extensions: [
        StarterKit,
      ],
      content: '<p>Hello, Tiptap!</p>',
    });
  }
});