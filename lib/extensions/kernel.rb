module Kernel
  # useful to reload files without warnings about redefining constants
  def silence_warnings
    old_verbose, $VERBOSE = $VERBOSE, nil
    yield
  ensure
    $VERBOSE = old_verbose
  end

  def var
    SymbolicVariable.new
  end
end