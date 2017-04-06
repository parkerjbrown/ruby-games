def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def black(text); colorize(text, 40); end
def red(text); colorize(text, 41); end
def green(text); colorize(text, 42); end
def yellow(text); colorize(text, 43); end
def blue(text); colorize(text, 44); end
def purple(text); colorize(text, 45); end
def teal(text); colorize(text, 46); end
def gray(text); colorize(text, 47); end