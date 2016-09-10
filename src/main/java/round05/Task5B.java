package round05;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.InputMismatchException;
import java.util.Stack;

public class Task5B {
  InputStream is;
  PrintWriter out;
  String INPUT = "8";
  private int n;
  private Stack<Character> stack = new Stack<Character>();

  void solve() {
    n = ni();
    gen(0, 0, 0, "");
  }

  private void gen(int pos, int open1, int open2, String str) {
    if (pos == n) {
      if (isValue(str)) {
        System.out.println(str);
      }
      return;
    }
    if (n - pos > open1 + open2) {
      gen(pos + 1, open1 + 1, open2, str + "(");
    }
    if (open1 > 0) {
      gen(pos + 1, open1 - 1, open2, str + ")");
    }
    if (n - pos > open2 + open1) {
      gen(pos + 1, open1, open2 + 1, str + "[");
    }
    if (open2 > 0) {
      gen(pos + 1, open1, open2 - 1, str + "]");
    }
  }

  private boolean isValue(String str) {
    stack.clear();
    for (int i = 0; i < n; i++) {
      int ch = str.charAt(i);
      if (ch == '(') {
        stack.push(')');
      } else if (ch == '[') {
        stack.push(']');
      } else {
        if (stack.isEmpty() || stack.pop() != ch) {
          return false;
        }
      }
    }
    return stack.isEmpty();
  }

  void solvebak() {
    int n = ni();
    String str = "";
    for (int i = 0; i < n / 2; i++) {
      str += "()";
    }
    do {
      System.out.println(str);
    } while ((str = nextValue(str, n)) != null);
  }

  private String nextValue(String str, int n) {
    String newstr = null;
    for (int i = str.length() - 1; i > 0; i--) {
      if (str.charAt(i - 1) == ')' && str.charAt(i) == '(') {
        newstr = str.substring(0, i - 1) + "()";
        break;
      }
    }
    if (newstr == null) {
      return null;
    }
    str = newstr;
    int open = 0;
    int j = 0;
    for (; j < str.length(); j++) {
      if (str.charAt(j) == '(') {
        open++;
      } else {
        open--;
      }
    }
    for (int i = 0; i < open; i++) {
      str += ')';
    }
    while (str.length() < n) {
      str += "()";
    }
    return str;
  }

  private boolean next(char[] a) {
    int i = 0;
    for (i = a.length - 1; i >= 1 ; i--) {
      if (a[i - 1] == ')' && a[i] == '(') {
        a[i - 1] = '(';
        a[i] = ')';
        break;
      }
    }
    if (i == 0) {
      return false;
    }
    int open = 0;
    for (int j = 0; j <= i; j++) {
      if (a[j] == '(') {
        open++;
      } else {
        open--;
      }
    }
    i++;
    while (open > 0) {
      open--;
      a[i] = ')';
      i++;
    }
    for (; i + 1 < a.length; i+=2) {
      a[i] = '(';
      a[i + 1] = ')';
    }
    return true;
  }

  public static void main(String[] args) throws Exception {
    new Task5B().run();
  }
  
  void run() throws Exception {
    is = oj ? System.in : new ByteArrayInputStream(INPUT.getBytes());
    out = new PrintWriter(System.out);
  
    long s = System.currentTimeMillis();
    solve();
    out.flush();
    tr(System.currentTimeMillis() - s + "ms");
  }
  
  private byte[] inbuf = new byte[1024];
  private int lenbuf = 0, ptrbuf = 0;
  
  private int readByte() {
    if (lenbuf == -1)
      throw new InputMismatchException();
    if (ptrbuf >= lenbuf) {
      ptrbuf = 0;
      try {
        lenbuf = is.read(inbuf);
      } catch (IOException e) {
        throw new InputMismatchException();
      }
      if (lenbuf <= 0)
        return -1;
    }
    return inbuf[ptrbuf++];
  }
  
  private boolean isSpaceChar(int c) {
    return !(c >= 33 && c <= 126);
  }
  
  private int skip() {
    int b;
    while ((b = readByte()) != -1 && isSpaceChar(b))
      ;
    return b;
  }
  
  private double nd() {
    return Double.parseDouble(ns());
  }
  
  private char nc() {
    return (char) skip();
  }
  
  private String ns() {
    int b = skip();
    StringBuilder sb = new StringBuilder();
    while (!(isSpaceChar(b))) { // when nextLine, (isSpaceChar(b) && b != ' ')
      sb.appendCodePoint(b);
      b = readByte();
    }
    return sb.toString();
  }
  
  private char[] ns(int n) {
    char[] buf = new char[n];
    int b = skip(), p = 0;
    while (p < n && !(isSpaceChar(b))) {
      buf[p++] = (char) b;
      b = readByte();
    }
    return n == p ? buf : Arrays.copyOf(buf, p);
  }
  
  private char[][] nm(int n, int m) {
    char[][] map = new char[n][];
    for (int i = 0; i < n; i++)
      map[i] = ns(m);
    return map;
  }
  
  private int[] na(int n) {
    int[] a = new int[n];
    for (int i = 0; i < n; i++)
      a[i] = ni();
    return a;
  }
  
  private int ni() {
    int num = 0, b;
    boolean minus = false;
    while ((b = readByte()) != -1 && !((b >= '0' && b <= '9') || b == '-'))
      ;
    if (b == '-') {
      minus = true;
      b = readByte();
    }
  
    while (true) {
      if (b >= '0' && b <= '9') {
        num = num * 10 + (b - '0');
      } else {
        return minus ? -num : num;
      }
      b = readByte();
    }
  }
  
  private long nl() {
    long num = 0;
    int b;
    boolean minus = false;
    while ((b = readByte()) != -1 && !((b >= '0' && b <= '9') || b == '-'))
      ;
    if (b == '-') {
      minus = true;
      b = readByte();
    }
  
    while (true) {
      if (b >= '0' && b <= '9') {
        num = num * 10 + (b - '0');
      } else {
        return minus ? -num : num;
      }
      b = readByte();
    }
  }
  
  private boolean oj = System.getProperty("ONLINE_JUDGE") != null;
  
  private void tr(Object... o) {
    if (!oj)
      System.out.println(Arrays.deepToString(o));
  }
}
