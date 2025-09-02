int abs(int i) {
  int res;
  if(i < 0)
    res = 0 - i;
  else 
    res = i;
  return res;
}

int main() {
  int a, b, c;
  return abs(-5);
}
