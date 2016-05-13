package round04;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.InputMismatchException;
import java.util.List;

public class Task4C {
  InputStream is;
  PrintWriter out;
  String INPUT = "2 17 100\n"
    + "5 0\n"
    + "50 33\n"
    + "6 1";
  String INPUT2 = "4 10 20\n"
    + "10 16 8 16\n"
    + "10 11 15 1\n"
    + "10 7 1 8";
  
  private static class Person implements Comparable<Person> {
    int t;
    int p;
    int s;

    public Person(int t, int p, int s) {
      this.t = t;
      this.p = p;
      this.s = s;
    }

    @Override
    public int compareTo(Person o) {
      int res = Integer.compare(t, o.t);
      if (res == 0) {
        res = Integer.compare(p, o.p);
      }
      return res;
    }

    @Override
    public String toString() {
      return "Person{t=" + t + ", p="+ p + ", s=" + s + "}";
    }
  }

  void solve() {
    int n = ni();
    int k = ni();
    int t = ni();
    int[] at = readArray(n);
    int[] ap = readArray(n);
    int[] as = readArray(n);
    List<Person> list = new ArrayList<>();
    for (int i = 0; i < n; i++) {
      if (as[i] <= k) {
        list.add(new Person(at[i], ap[i], as[i]));
      }
    }
    Collections.sort(list);
    int[] d = new int[n];
    int res = 0;
    for (int i = 0; i < list.size(); i++) {
      Person p = list.get(i);
      int max = isOpenable(0, p.s, 0, p.t) ? p.p : 0;
      for (int j = 0; j < i; j++) {
        Person p2 = list.get(j);
        if (d[j] > 0 && isOpenable(p2.s, p.s, p2.t, p.t)) {
          max = Math.max(max, p.p + d[j]);
        }
      }
      d[i] = max;
      res = Math.max(max, res);
    }
    out.println(res);
  }

  private boolean isOpenable(int ck, int s, int ctime, int t) {
    int dt = t - ctime;
    int ds = Math.abs(ck - s);
    return dt >= ds;
  }


  private int[] readArray(int n) {
    int[] a = new int[n];
    for (int i = 0; i < n; i++) {
      a[i] = ni();
    }
    return a;
  }
  
  public static void main(String[] args) throws Exception {
    new Task4C().run();
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
