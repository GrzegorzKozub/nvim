return {
  settings = {
    ['rust-analyzer'] = {
      inlayHints = {
        bindingModeHints = { enable = true },
        closureCaptureHints = { enable = true },
        closureReturnTypeHints = { enable = 'always' },
        discriminantHints = { enable = 'always' },
        expressionAdjustmentHints = { enable = 'always' },
        implicitDrops = { enable = true },
        lifetimeElisionHints = { enable = 'always' },
        rangeExclusiveHints = { enable = true },
        reborrowHints = { enable = 'always' },
      },
    },
  },
}
