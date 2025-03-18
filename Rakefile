require "bundler/setup"

APP_RAKEFILE = File.expand_path("spec/dummy/Rakefile", __dir__)
load "rails/tasks/engine.rake"

load "rails/tasks/statistics.rake"

require "bundler/gem_tasks"

# Many tasks are namespaced with `app:`. Here is an explanation, courtesy of Perplexity:
#
#  You're correct - the `app:` namespace prefix for rake tasks in your engine's dummy application comes from **Rails' engine architecture conventions**, not from explicit configuration in your Rakefile. Here's the detailed explanation:
#
# ### 1. **Engine Task Namespacing Mechanism**
# Rails automatically wraps rake tasks in `app:` when loaded through an engine's dummy app due to:
# - **Railties' EngineTask** class (`railties/lib/rails/engine/railties.rb`)
# - **Task delegation** in the engine initialization process
# - **Isolation** between engine and host application
#
# ### 2. **Key Components in Rails Source**
# The magic happens in these components:
# ```ruby
# # railties/lib/rails/engine/railties.rb
# module EngineTasks
#   def task_namespace
#     @task_namespace ||= namespace.sub(/::rake_test_loader$/, '').underscore.tr('/', ':')
#   end
# end
# ```
#
# ### 3. **Automatic Namespace Generation**
# For your dummy app (`spec/dummy`), Rails:
# 1. Treats it as a mountable engine
# 2. Derives the namespace from the engine's module name
# 3. Uses `app:` as the default namespace for the dummy application
#
# ### 4. **Namespace Inheritance**
# Your dummy app inherits this behavior through:
# ```ruby
# # Your engine's lib/blorgh/engine.rb
# module Blorgh
#   class Engine < ::Rails::Engine
#     isolate_namespace Blorgh  # This config enables the namespacing
#   end
# end
# ```
#
# ### 5. **Task Loading Sequence**
# When you run `rake -T` in your engine:
# 1. Loads engine Rakefile
# 2. Delegates to dummy app via `APP_RAKEFILE`
# 3. Rails engine code automatically wraps tasks in `app:`
#    ```ruby
#    # railties/lib/rails/engine.rb
#    def run_tasks_blocks(app)
#      self.tasks.each { |block| block.call(app) }
#    end
#    ```
#
# ### 6. **Why You Don't See Explicit Configuration**
# The namespace prefix is added through Rails' internal task loading process:
# - **TaskProxy** class handles namespacing
# - **Rake::Application** monkey-patched by Railties
# - **Automatic engine isolation** via `isolate_namespace`
#
# ### Solution for Clarity
# If you want explicit control, add this to your engine definition:
# ```ruby
# # lib/blorgh/engine.rb
# module Blorgh
#   class Engine < Rails::Engine
#     isolate_namespace Blorgh
#
#     # Customize task namespace
#     config.app_generators do |g|
#       g.rails :tasks, namespace: :blorgh
#     end
#   end
# end
# ```
#
# This namespacing behavior is fundamental to Rails' engine architecture, ensuring task isolation between engines and host applications. The dummy app inherits this behavior through Rails' internal engine initialization process rather than explicit configuration.
