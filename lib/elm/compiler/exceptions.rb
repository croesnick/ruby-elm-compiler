module Elm
  class Compiler
    class Error < StandardError; end
    class ExecutableNotFound < Error; end
    class CompileError < Error; end
    class NameCollisionError < Error; end
  end
end
