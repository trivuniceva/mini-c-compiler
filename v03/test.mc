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

  int a = 1; 
  unsigned b = 5u, c = 10u;
  
  return abs(-5);
}
