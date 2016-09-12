package round06;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayDeque;
import java.util.Arrays;
import java.util.InputMismatchException;

public class Task6F {
  InputStream is;
  PrintWriter out;
  String INPUT2 = "5\n" +
    ".....\n" +
    "...##\n" +
    "..#..\n" +
    "..###\n" +
    ".....\n";
  String INPUT = "4\n" +
  ".#..\n" +
  ".#..\n" +
  "..##\n" +
  "....\n";
  
  void solve() {
    int n = ni();
    int[][] map = new int[n + 2][n + 2];
    Arrays.fill(map[0], -1);
    Arrays.fill(map[n + 1], -1);
    for (int i = 0; i < n; i++) {
      Arrays.fill(map[i + 1], -1);
      char[] row = ns().toCharArray();
      for (int j = 0; j < n; j++) {
        int ch = row[j];
        if (ch == '#') {
          map[i + 1][j + 1] = 1;
        } else {
          map[i + 1][j + 1] = 0;
        }
      }
    }
    map[0][0] = map[1][0] = map[0][1] = -2;
    map[n + 1][n + 1] = map[n + 1][n] = map[n][n + 1] = -2;
    int[] xy = new int[]{0, -1, 0, 1, -1, 0, 1, 0};
    ArrayDeque<Integer> q = new ArrayDeque<Integer>();
    q.add(1 * (n + 2) + 1);
    q.add(n * (n + 2) + n);
    map[1][1] = 3;
    map[n][n] = 3;
    int res = 0;
    while (!q.isEmpty()) {
      int pos = q.pop();
      int y = pos / (n + 2);
      int x = pos % (n + 2);
      for (int i = 0; i < 4; i++) {
        int dy = xy[i * 2];
        int dx = xy[i * 2 + 1];
        int ny = dy + y;
        int nx = dx + x;
        if (map[ny][nx] == -1 || map[ny][nx] == 1) {
          res++;
        }
      }
      for (int i = 0; i < 4; i++) {
        int dy = xy[i * 2];
        int dx = xy[i * 2 + 1];
        int ny = dy + y;
        int nx = dx + x;
        if (map[ny][nx] == 0) {
          q.add(ny * (n + 2) + nx);
          map[ny][nx] = 3;
        }
      }
    }
    for (int i = 0; i < n + 2; i++) {
      tr(Arrays.toString(map[i]));
    }
    System.out.println(res * 9);
  }
  
  public static void main(String[] args) throws Exception {
    new Task6F().run();
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
