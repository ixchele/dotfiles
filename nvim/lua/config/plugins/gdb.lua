return {
  {
	  "mfussenegger/nvim-dap",
	  config = function()
		  local dap, dapui = require("dap"), require("dapui")

		  dap.listeners.after.event_initialized["dapui_config"] = function()
			  dapui.open()
		  end
		  dap.listeners.before.event_terminated["dapui_config"] = function()
			  dapui.close()
		  end
		  dap.listeners.before.event_exited["dapui_config"] = function()
			  dapui.close()
		  end
	  end,
  },
  {
	"nvim-neotest/nvim-nio",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
      require("dapui").setup()
    end
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end
  },
}
