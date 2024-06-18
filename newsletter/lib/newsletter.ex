defmodule Newsletter do
  def read_emails(path) do
    binary = File.read!(path)

    String.split(binary, "\n", trim: true)
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    emails = read_emails(emails_path)
    logs_pid = open_log(log_path)

    do_send_emails(emails, send_fun, logs_pid)

    close_log(logs_pid)
  end

  defp do_send_emails(email, send_fn, log_pid)
  defp do_send_emails([], _, _), do: :ok
  defp do_send_emails([email | tail], send_fn, log_pid) do
    case send_fn.(email) do
      :ok -> log_sent_email(log_pid, email)
      _ -> nil
    end

    do_send_emails(tail, send_fn, log_pid)
  end
end
