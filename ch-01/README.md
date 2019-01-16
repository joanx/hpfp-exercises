# Week 1 Exercises

Intermission: Equivalence Exercises

1. c
2. c
3. b

Combinators:

1. Yes
2. No
3. Yes
4. Yes
5. Yes

Normal form or diverge?

1. Normal
2. Diverge
3. Normal

Beta reduce

1.
(λabc.cba)zz(λwv.w)
(λ[a := z][b := z]c.cba)zz(λwv.w)
(λc.czz)(λwv.w)
(λ[c := (λwv.w)].czz)
(λwv.w)zz
(λ[w := z][v := z].w)
z

2.
(λx.λy.xyy)(λa.a)b
(λ[x := (λa.a)].λy.xyy)b
(λy.(λa.a)yy)b
(λy.(λ[a := yy].a))b
(λy.yy)b
bb

3.
(λy.y)(λx.xx)(λz.zq)
(λx.xx)(λz.zq)
(λz.zq)(λz.zq)
(λ[z := (λz.zq)].zq)
(λz.zq)q
qq

4.
(λz.z)(λz.zz)(λz.zy)
(λz.zz)(λz.zy)
(λ[z := (λz.zy)].zy)
(λz.zy)y
yy

5.
(λx.λy.xyy)(λz.z)y
(λ[x := (λz.z)].λy.xyy)y
(λy.(λz.z)yy)y
(λy.yy)y
yy

6.
(λa.aa)(λb.ba)c
(λb.ba)(λb.ba)c
((λb.ba)a)c
(aa)c
aac

7.
(λx.y.z.xz(yz))(λx.z)(λx.a)
(λ[x := (λx.z)].[y := (λx.a)].z.xz(yz))
(λz.(λx.z)z((λx.a)z))
(λz.(λx.z)za)
<!-- Rename variable to distinguish z's -->
(λg.(λx.z)ga)
(λg.(λ[x := g].z)a)
(λg.za)
