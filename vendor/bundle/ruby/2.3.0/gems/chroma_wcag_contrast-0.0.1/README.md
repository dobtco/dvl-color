ChromaWcagContrast
---

Calculates the WCAG contrast ratio between two `Chroma::Color`s. If you need this ratio, and you also use [chroma](https://github.com/jfairbank/chroma), then this library may be for you. Otherwise, you might prefer https://github.com/mkdynamic/wcag_color_contrast.

Available on Rubygems as `chroma_wcag_contrast`.

```rb
ChromaWcagContrast.ratio(
  Chroma.paint('999'),
  Chroma.paint('ffffff')
) # => 2.849
```

### License

MIT
