local function add_mappings()
	local status_ok, overseer = pcall(require, "overseer")
	if not status_ok then
		return
	end

	local param_definitions = {
		directory = {
			type = "string",
			name = "Directory to execute the command on",
		},
	}

	overseer.register_template({
		name = "ruff check",
		builder = function(params)
			return {
				cmd = { "ruff", "check", params.directory },
				components = {
					{ "on_output_quickfix", open = true },
					"on_output_summarize",
					"default",
				},
			}
		end,
		params = param_definitions,
		default_params = { directory = "." },
		tags = { "linting", "python" },
	})

	overseer.register_template({
		name = "mypy",
		builder = function(params)
			return {
				cmd = { "mypy", params.directory },
				components = {
					{ "on_output_quickfix", open = true },
					"on_output_summarize",
					"default",
				},
			}
		end,
		params = param_definitions,
		tags = { "linting", "python" },
	})
end

add_mappings()
