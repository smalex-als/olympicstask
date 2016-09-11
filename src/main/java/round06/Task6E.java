package round06;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayDeque;
import java.util.Arrays;
import java.util.InputMismatchException;

public class Task6E {
  // problem http://codeforces.com/contest/6/problem/E
  InputStream is;
  PrintWriter out;
  String INPUT = "5\n"
    + "....X\n"
    + ".OOOO\n"
    + ".....\n"
    + "OOOO.\n"
    + "@....";
  String INPUT2 = "5\n"
    + "....X\n"
    + ".....\n"
    + "OOOOO\n"
    + ".....\n"
    + "..@..";
  String INPUT3 = "5\n"
    + "...X.\n"
    + ".....\n"
    + "O.OOO\n"
    + ".....\n"
    + "....@";
  String INPUT6 = "2\n" 
  + "@O\n" 
  + "OX\n";
  
  void solve() {
    int[] xy = new int[]{-1, 0, 1, 0, 
      0, 1, 0, -1};
    int n = ni();
    int[][] map = new int[n][n];
    int starty = 0;
    int startx = 0;
    int endy = 0;
    int endx = 0;
    for (int i = 0; i < n; i++) {
      char[] chs = ns().toCharArray();
      for (int j = 0; j < n; j++) {
        int ch = chs[j];
        if (ch == '@') {
          starty = i;
          startx = j;
          map[i][j] = 0;
        } else if (ch == 'X') {
          endy = i;
          endx = j;
          map[i][j] = -2;
        } else {
          map[i][j] = ch == 'O' ? -1 : -2; 
        }
      }
    }
    ArrayDeque<Integer> q = new ArrayDeque<>();
    q.add(starty * n + startx);
    while (!q.isEmpty()) {
      int p = q.poll();
      int cy = p / n;
      int cx = p % n;
      for (int i = 0; i < 4; i++) {
        int newy = cy + xy[i*2];
        int newx = cx + xy[i*2 + 1];
        if (newx >= 0 && newx < n && newy >= 0 && newy < n) {
          if (map[newy][newx] == -2 || map[newy][newx] > 
              map[cy][cx] + 1) {
            map[newy][newx] = map[cy][cx] + 1;
            q.push(newy * n + newx);
          }
        }
      }
    }
    if (map[endy][endx] == -2) {
      System.out.println("N");
      return;
    }
    int cy = endy;
    int cx = endx;
    for (int j = map[endy][endx]; j > 0; j--) {
      map[cy][cx] = -3;
      for (int i = 0; i < 4; i++) {
        int newy = cy + xy[i*2];
        int newx = cx + xy[i*2 + 1];
        if (newx >= 0 && newx < n && newy >= 0 && newy < n) {
          if (map[newy][newx] + 1 == j) {
            cy = newy;
            cx = newx;
            break;
          }
        }
      }
    }
    System.out.println("Y");
    for (int i = 0; i < n; i++) {
      StringBuilder sb = new StringBuilder();
      for (int j = 0; j < n; j++) {
        if (starty == i && startx == j) {
          sb.append("@");
        } else if (map[i][j] == -1) {
          sb.append("O");
        } else if (map[i][j] == -3) {
          sb.append("+");
        } else {
          sb.append(".");
        }
      }
      System.out.println(sb.toString());
    }
  }
  
  public static void main(String[] args) throws Exception {
    new Task6E().run();
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
