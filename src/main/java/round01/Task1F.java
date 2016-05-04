package round01;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.InputMismatchException;

public class Task1F {
  InputStream is;
  PrintWriter out;
  String INPUT = "1 4 1 1 4";
  
  void solve() {
    int[] a = new int[5];
    for (int i = 0; i < 5; i++) {
      a[i] = ni();
    }
    Arrays.sort(a);
    if (isImpossible(a)) {
      System.out.println("Impossible");
    } else if (isFourOfKind(a, 4)) {
      System.out.println("Four of a Kind");
    } else if (isFullHouse(a)) {
      System.out.println("Full House");
    } else if (isStraight(a)) {
      System.out.println("Straight");
    } else if (isFourOfKind(a, 3)) {
      System.out.println("Three of a Kind");
    } else if (isTwoPairs(a, 2)) {
      System.out.println("Two Pairs");
    } else if (isTwoPairs(a, 1)) {
      System.out.println("One Pair");
    } else {
      System.out.println("Nothing");
    }
  }

  private boolean isTwoPairs(int[] a, int expected) {
    int[] cnt = new int[14];
    for (int i = 0; i < 5; i++) {
      cnt[a[i]]++;
    }
    int res = 0;
    for (int i = 0; i < cnt.length; i++) {
      if (cnt[i] == 2) {
        res++;
      }
    }
    return res == expected;
  }

  private boolean isStraight(int[] a) {
    for (int i = 0; i < 4; i++) {
      if (a[i] != a[i + 1] - 1) {
        return false;
      }
    }
    return true;
  }

  private boolean isFullHouse(int[] a) {
    int cntA = 0;
    int cntB = 0;
    for (int i = 0; i < 4; i++) {
      if (a[i] == a[i + 1]) {
        cntA++;
      } else {
        break;
      }
    }
    for (int i = 4; i > 0; i--) {
      if (a[i] == a[i - 1]) {
        cntB++;
      } else {
        break;
      }
    }
    return (cntA + 1 == 3 && cntB + 1 == 2)
      || (cntA + 1 == 2 && cntB + 1 == 3);
  }

  private boolean isFourOfKind(int[] a, int expected) {
    int[] cnt = new int[14];
    for (int i = 0; i < 5; i++) {
      cnt[a[i]]++;
    }
    for (int i = 0; i < cnt.length; i++) {
      if (cnt[i] == expected) {
        return true;
      }
    }
    return false;
  }

  private boolean isImpossible(int[] a) {
    for (int i = 0; i < 4; i++) {
      if (a[i] != a[i + 1]) {
        return false;
      }
    }
    return true;
  }

  public static void main(String[] args) throws Exception {
    new Task1F().run();
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
