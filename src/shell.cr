class Shell

  def initialize(@cmd : String,
                 @stdout : Process::Stdio = IO::Memory.new,
                 @stderr : Process::Stdio = IO::Memory.new,
                 @fail_on_error : Bool = true
                )
    @status = 0

  end

  # getter :stderr

  def stdout
    @stdout.to_s
  end

  def stderr
    @stderr.to_s
  end

  def fail_on_error? : Bool
    @fail_on_error
  end

  def success? : Bool
    @status == 0
  end

  def failed? : Bool
    !success?
  end

  def should_fail? : Bool
    failed? && fail_on_error?
  end

  def fail
    raise "Shell command failed (status: #{@status}) with an error: \n" + @stderr.to_s
  end

  def run() : String
    @status = Process.run(@cmd,
                          shell: true,
                          output: @stdout,
                          error: @stderr)
              .exit_code

    fail if should_fail?

    stdout
  end

  def self.run( cmd , fail_on_error = true ) : String
    new(cmd, fail_on_error: fail_on_error).run
  end



end
