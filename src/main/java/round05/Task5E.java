package round05;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.InputMismatchException;

public class Task5E {
  InputStream is;
  PrintWriter out;
  String INPUT = "36 10 ABC";
  
  void solve() {
    int from = ni();
    int to = ni();
    String number = ns();
    int[] n0 = readNumber(number);
    int[] res = new int[6000];
    int len = 0;
    do {
      res[len++] = divshort(n0, to, from);
    } while (!isEmpty(n0));
    printNumber(res, len);
  }

  private int[] readNumber(String str) {
    int len = str.length();
    int[] a = new int[len]; 
    int end = len;
    for (int i = 0; i < len; i++) {
      int ch = str.charAt(i);
      int value = 0;
      if (ch >= '0' && ch <= '9') {
        value = ch - '0';
      } else if (ch >= 'A' && ch <= 'Z') {
        value = ch - 'A' + 10;
      }
      a[--end] = value;
    }
    return a;
  }

  private int divshort(int[] n, int divisor, int from) {
    int rem = 0;
    for (int i = n.length - 1; i >= 0; i--) {
      rem = rem * from + n[i];
      n[i] = rem / divisor;
      rem = rem % divisor;
    }
    return rem;
  }

  private boolean isEmpty(int[] a) {
    for (int i = 0; i < a.length; i++) {
      if (a[i] > 0) return false;
    }
    return true;
  }

  private void printNumber(int[] n, int len) {
    int i;
    for (i = len - 1; i > 0 && n[i] == 0; i--);
    for (; i >= 0; i--) {
      int ch = n[i]; 
      if (ch <= 9) {
        out.print((char) ('0' + ch));
      } else {
        out.print((char) ('A' + ch - 10));
      }
    }
    out.println();
  }
  
  public static void main(String[] args) throws Exception {
    new Task5E().run();
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
