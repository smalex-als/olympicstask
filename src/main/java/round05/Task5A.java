package round05;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.InputMismatchException;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

public class Task5A {
  InputStream is;
  PrintWriter out;
  String INPUT = "200 250";
  
  void solve() {
    int m = ni();
    int n = ni();
    boolean found = false;
    for (int i = m; i <= n; i++) {
      int sum = getSum(i);
      if (m <= i && i < sum && sum <= n && getSum(sum) == i) {
        System.out.println(i + " " + sum);
        found = true;
      }
    }
    if (!found) {
      System.out.println("Absent");
    }
  }

  private int getSum(int n) {
    int sum = 0;
    Set<Integer> numbers = new LinkedHashSet<Integer>();
    List<Integer> add = new ArrayList<Integer>();
    numbers.add(1);
    int max = (int) Math.sqrt(n) + 1;
    int div = 2;
    int num = n;
    while (div < max) {
      if (num % div == 0) {
        numbers.add(div);
        num /= div;
        max = (int) Math.sqrt(num) + 1;
        add.clear();
        for (int p : numbers) {
          int newnum = p * div;
          if (newnum < n && n % newnum == 0) {
            add.add(newnum);
          }
        }
        numbers.addAll(add);
        continue;
      }
      div++;
    }
    if (num != n) {
      add.clear();
      for (int p : numbers) {
        int newnum = p * num;
        if (newnum < n && n % newnum == 0) {
          add.add(newnum);
        }
      }
      numbers.addAll(add);
    }
    for (int p : numbers) {
      sum += p;
    }
    return sum;
  }
  
  public static void main(String[] args) throws Exception {
    new Task5A().run();
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
