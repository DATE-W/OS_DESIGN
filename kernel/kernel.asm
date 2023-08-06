
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00022117          	auipc	sp,0x22
    80000004:	17010113          	addi	sp,sp,368 # 80022170 <stack0>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	467050ef          	jal	ra,80005c7c <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	7139                	addi	sp,sp,-64
    8000001e:	fc06                	sd	ra,56(sp)
    80000020:	f822                	sd	s0,48(sp)
    80000022:	f426                	sd	s1,40(sp)
    80000024:	f04a                	sd	s2,32(sp)
    80000026:	ec4e                	sd	s3,24(sp)
    80000028:	e852                	sd	s4,16(sp)
    8000002a:	e456                	sd	s5,8(sp)
    8000002c:	0080                	addi	s0,sp,64
    8000002e:	84aa                	mv	s1,a0
  struct run *r;
  push_off();
    80000030:	00006097          	auipc	ra,0x6
    80000034:	5e4080e7          	jalr	1508(ra) # 80006614 <push_off>
  int c = cpuid();
    80000038:	00001097          	auipc	ra,0x1
    8000003c:	ed2080e7          	jalr	-302(ra) # 80000f0a <cpuid>
    80000040:	8a2a                	mv	s4,a0
  pop_off();
    80000042:	00006097          	auipc	ra,0x6
    80000046:	68e080e7          	jalr	1678(ra) # 800066d0 <pop_off>

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    8000004a:	03449793          	slli	a5,s1,0x34
    8000004e:	e7a5                	bnez	a5,800000b6 <kfree+0x9a>
    80000050:	0002b797          	auipc	a5,0x2b
    80000054:	1f878793          	addi	a5,a5,504 # 8002b248 <end>
    80000058:	04f4ef63          	bltu	s1,a5,800000b6 <kfree+0x9a>
    8000005c:	47c5                	li	a5,17
    8000005e:	07ee                	slli	a5,a5,0x1b
    80000060:	04f4fb63          	bgeu	s1,a5,800000b6 <kfree+0x9a>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000064:	6605                	lui	a2,0x1
    80000066:	4585                	li	a1,1
    80000068:	8526                	mv	a0,s1
    8000006a:	00000097          	auipc	ra,0x0
    8000006e:	1ec080e7          	jalr	492(ra) # 80000256 <memset>

  r = (struct run*)pa;

  acquire(&kmem[c].lock);
    80000072:	00009a97          	auipc	s5,0x9
    80000076:	fbea8a93          	addi	s5,s5,-66 # 80009030 <kmem>
    8000007a:	002a1993          	slli	s3,s4,0x2
    8000007e:	01498933          	add	s2,s3,s4
    80000082:	090e                	slli	s2,s2,0x3
    80000084:	9956                	add	s2,s2,s5
    80000086:	854a                	mv	a0,s2
    80000088:	00006097          	auipc	ra,0x6
    8000008c:	5d8080e7          	jalr	1496(ra) # 80006660 <acquire>
  r->next = kmem[c].freelist;
    80000090:	02093783          	ld	a5,32(s2)
    80000094:	e09c                	sd	a5,0(s1)
  kmem[c].freelist = r;
    80000096:	02993023          	sd	s1,32(s2)
  release(&kmem[c].lock);
    8000009a:	854a                	mv	a0,s2
    8000009c:	00006097          	auipc	ra,0x6
    800000a0:	694080e7          	jalr	1684(ra) # 80006730 <release>
}
    800000a4:	70e2                	ld	ra,56(sp)
    800000a6:	7442                	ld	s0,48(sp)
    800000a8:	74a2                	ld	s1,40(sp)
    800000aa:	7902                	ld	s2,32(sp)
    800000ac:	69e2                	ld	s3,24(sp)
    800000ae:	6a42                	ld	s4,16(sp)
    800000b0:	6aa2                	ld	s5,8(sp)
    800000b2:	6121                	addi	sp,sp,64
    800000b4:	8082                	ret
    panic("kfree");
    800000b6:	00008517          	auipc	a0,0x8
    800000ba:	f5a50513          	addi	a0,a0,-166 # 80008010 <etext+0x10>
    800000be:	00006097          	auipc	ra,0x6
    800000c2:	06e080e7          	jalr	110(ra) # 8000612c <panic>

00000000800000c6 <freerange>:
{
    800000c6:	7179                	addi	sp,sp,-48
    800000c8:	f406                	sd	ra,40(sp)
    800000ca:	f022                	sd	s0,32(sp)
    800000cc:	ec26                	sd	s1,24(sp)
    800000ce:	e84a                	sd	s2,16(sp)
    800000d0:	e44e                	sd	s3,8(sp)
    800000d2:	e052                	sd	s4,0(sp)
    800000d4:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    800000d6:	6785                	lui	a5,0x1
    800000d8:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800000dc:	94aa                	add	s1,s1,a0
    800000de:	757d                	lui	a0,0xfffff
    800000e0:	8ce9                	and	s1,s1,a0
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000e2:	94be                	add	s1,s1,a5
    800000e4:	0095ee63          	bltu	a1,s1,80000100 <freerange+0x3a>
    800000e8:	892e                	mv	s2,a1
    kfree(p);
    800000ea:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000ec:	6985                	lui	s3,0x1
    kfree(p);
    800000ee:	01448533          	add	a0,s1,s4
    800000f2:	00000097          	auipc	ra,0x0
    800000f6:	f2a080e7          	jalr	-214(ra) # 8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000fa:	94ce                	add	s1,s1,s3
    800000fc:	fe9979e3          	bgeu	s2,s1,800000ee <freerange+0x28>
}
    80000100:	70a2                	ld	ra,40(sp)
    80000102:	7402                	ld	s0,32(sp)
    80000104:	64e2                	ld	s1,24(sp)
    80000106:	6942                	ld	s2,16(sp)
    80000108:	69a2                	ld	s3,8(sp)
    8000010a:	6a02                	ld	s4,0(sp)
    8000010c:	6145                	addi	sp,sp,48
    8000010e:	8082                	ret

0000000080000110 <kinit>:
{
    80000110:	7179                	addi	sp,sp,-48
    80000112:	f406                	sd	ra,40(sp)
    80000114:	f022                	sd	s0,32(sp)
    80000116:	ec26                	sd	s1,24(sp)
    80000118:	e84a                	sd	s2,16(sp)
    8000011a:	e44e                	sd	s3,8(sp)
    8000011c:	1800                	addi	s0,sp,48
  for (int i = 0; i<NCPU; i++)
    8000011e:	00009497          	auipc	s1,0x9
    80000122:	f1248493          	addi	s1,s1,-238 # 80009030 <kmem>
    80000126:	00009997          	auipc	s3,0x9
    8000012a:	04a98993          	addi	s3,s3,74 # 80009170 <pid_lock>
    initlock(&kmem[i].lock, "kmem");
    8000012e:	00008917          	auipc	s2,0x8
    80000132:	eea90913          	addi	s2,s2,-278 # 80008018 <etext+0x18>
    80000136:	85ca                	mv	a1,s2
    80000138:	8526                	mv	a0,s1
    8000013a:	00006097          	auipc	ra,0x6
    8000013e:	6a2080e7          	jalr	1698(ra) # 800067dc <initlock>
  for (int i = 0; i<NCPU; i++)
    80000142:	02848493          	addi	s1,s1,40
    80000146:	ff3498e3          	bne	s1,s3,80000136 <kinit+0x26>
  freerange(end, (void*)PHYSTOP);
    8000014a:	45c5                	li	a1,17
    8000014c:	05ee                	slli	a1,a1,0x1b
    8000014e:	0002b517          	auipc	a0,0x2b
    80000152:	0fa50513          	addi	a0,a0,250 # 8002b248 <end>
    80000156:	00000097          	auipc	ra,0x0
    8000015a:	f70080e7          	jalr	-144(ra) # 800000c6 <freerange>
}
    8000015e:	70a2                	ld	ra,40(sp)
    80000160:	7402                	ld	s0,32(sp)
    80000162:	64e2                	ld	s1,24(sp)
    80000164:	6942                	ld	s2,16(sp)
    80000166:	69a2                	ld	s3,8(sp)
    80000168:	6145                	addi	sp,sp,48
    8000016a:	8082                	ret

000000008000016c <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    8000016c:	7139                	addi	sp,sp,-64
    8000016e:	fc06                	sd	ra,56(sp)
    80000170:	f822                	sd	s0,48(sp)
    80000172:	f426                	sd	s1,40(sp)
    80000174:	f04a                	sd	s2,32(sp)
    80000176:	ec4e                	sd	s3,24(sp)
    80000178:	e852                	sd	s4,16(sp)
    8000017a:	e456                	sd	s5,8(sp)
    8000017c:	0080                	addi	s0,sp,64
  struct run *r;
  push_off();
    8000017e:	00006097          	auipc	ra,0x6
    80000182:	496080e7          	jalr	1174(ra) # 80006614 <push_off>
  int c = cpuid();
    80000186:	00001097          	auipc	ra,0x1
    8000018a:	d84080e7          	jalr	-636(ra) # 80000f0a <cpuid>
    8000018e:	84aa                	mv	s1,a0
  pop_off();
    80000190:	00006097          	auipc	ra,0x6
    80000194:	540080e7          	jalr	1344(ra) # 800066d0 <pop_off>

  acquire(&kmem[c].lock);
    80000198:	00249993          	slli	s3,s1,0x2
    8000019c:	99a6                	add	s3,s3,s1
    8000019e:	00399793          	slli	a5,s3,0x3
    800001a2:	00009997          	auipc	s3,0x9
    800001a6:	e8e98993          	addi	s3,s3,-370 # 80009030 <kmem>
    800001aa:	99be                	add	s3,s3,a5
    800001ac:	854e                	mv	a0,s3
    800001ae:	00006097          	auipc	ra,0x6
    800001b2:	4b2080e7          	jalr	1202(ra) # 80006660 <acquire>
  r = kmem[c].freelist;
    800001b6:	0209b903          	ld	s2,32(s3)
  if(r)
    800001ba:	02090c63          	beqz	s2,800001f2 <kalloc+0x86>
  {
    kmem[c].freelist = r->next;
    800001be:	00093703          	ld	a4,0(s2)
    800001c2:	02e9b023          	sd	a4,32(s3)
    release(&kmem[c].lock);
    800001c6:	854e                	mv	a0,s3
    800001c8:	00006097          	auipc	ra,0x6
    800001cc:	568080e7          	jalr	1384(ra) # 80006730 <release>
        release(&kmem[i].lock);
      }
    }
  }
  if(r)
    memset((char*)r, 5, PGSIZE);  // fill with junk
    800001d0:	6605                	lui	a2,0x1
    800001d2:	4595                	li	a1,5
    800001d4:	854a                	mv	a0,s2
    800001d6:	00000097          	auipc	ra,0x0
    800001da:	080080e7          	jalr	128(ra) # 80000256 <memset>
  return (void*)r;
    800001de:	854a                	mv	a0,s2
    800001e0:	70e2                	ld	ra,56(sp)
    800001e2:	7442                	ld	s0,48(sp)
    800001e4:	74a2                	ld	s1,40(sp)
    800001e6:	7902                	ld	s2,32(sp)
    800001e8:	69e2                	ld	s3,24(sp)
    800001ea:	6a42                	ld	s4,16(sp)
    800001ec:	6aa2                	ld	s5,8(sp)
    800001ee:	6121                	addi	sp,sp,64
    800001f0:	8082                	ret
    release(&kmem[c].lock);
    800001f2:	854e                	mv	a0,s3
    800001f4:	00006097          	auipc	ra,0x6
    800001f8:	53c080e7          	jalr	1340(ra) # 80006730 <release>
    for (int i = 0; i<NCPU; i++)
    800001fc:	00009497          	auipc	s1,0x9
    80000200:	e3448493          	addi	s1,s1,-460 # 80009030 <kmem>
    80000204:	4981                	li	s3,0
    80000206:	4a21                	li	s4,8
      acquire(&kmem[i].lock);
    80000208:	8526                	mv	a0,s1
    8000020a:	00006097          	auipc	ra,0x6
    8000020e:	456080e7          	jalr	1110(ra) # 80006660 <acquire>
      r = kmem[i].freelist;
    80000212:	0204b903          	ld	s2,32(s1)
      if(r)
    80000216:	00091d63          	bnez	s2,80000230 <kalloc+0xc4>
        release(&kmem[i].lock);
    8000021a:	8526                	mv	a0,s1
    8000021c:	00006097          	auipc	ra,0x6
    80000220:	514080e7          	jalr	1300(ra) # 80006730 <release>
    for (int i = 0; i<NCPU; i++)
    80000224:	2985                	addiw	s3,s3,1
    80000226:	02848493          	addi	s1,s1,40
    8000022a:	fd499fe3          	bne	s3,s4,80000208 <kalloc+0x9c>
    8000022e:	bf45                	j	800001de <kalloc+0x72>
        kmem[i].freelist = r->next;
    80000230:	00093703          	ld	a4,0(s2)
    80000234:	00299793          	slli	a5,s3,0x2
    80000238:	99be                	add	s3,s3,a5
    8000023a:	098e                	slli	s3,s3,0x3
    8000023c:	00009797          	auipc	a5,0x9
    80000240:	df478793          	addi	a5,a5,-524 # 80009030 <kmem>
    80000244:	99be                	add	s3,s3,a5
    80000246:	02e9b023          	sd	a4,32(s3)
        release(&kmem[i].lock);
    8000024a:	8526                	mv	a0,s1
    8000024c:	00006097          	auipc	ra,0x6
    80000250:	4e4080e7          	jalr	1252(ra) # 80006730 <release>
        break;
    80000254:	bfb5                	j	800001d0 <kalloc+0x64>

0000000080000256 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80000256:	1141                	addi	sp,sp,-16
    80000258:	e422                	sd	s0,8(sp)
    8000025a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    8000025c:	ce09                	beqz	a2,80000276 <memset+0x20>
    8000025e:	87aa                	mv	a5,a0
    80000260:	fff6071b          	addiw	a4,a2,-1
    80000264:	1702                	slli	a4,a4,0x20
    80000266:	9301                	srli	a4,a4,0x20
    80000268:	0705                	addi	a4,a4,1
    8000026a:	972a                	add	a4,a4,a0
    cdst[i] = c;
    8000026c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000270:	0785                	addi	a5,a5,1
    80000272:	fee79de3          	bne	a5,a4,8000026c <memset+0x16>
  }
  return dst;
}
    80000276:	6422                	ld	s0,8(sp)
    80000278:	0141                	addi	sp,sp,16
    8000027a:	8082                	ret

000000008000027c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    8000027c:	1141                	addi	sp,sp,-16
    8000027e:	e422                	sd	s0,8(sp)
    80000280:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    80000282:	ca05                	beqz	a2,800002b2 <memcmp+0x36>
    80000284:	fff6069b          	addiw	a3,a2,-1
    80000288:	1682                	slli	a3,a3,0x20
    8000028a:	9281                	srli	a3,a3,0x20
    8000028c:	0685                	addi	a3,a3,1
    8000028e:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    80000290:	00054783          	lbu	a5,0(a0)
    80000294:	0005c703          	lbu	a4,0(a1)
    80000298:	00e79863          	bne	a5,a4,800002a8 <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    8000029c:	0505                	addi	a0,a0,1
    8000029e:	0585                	addi	a1,a1,1
  while(n-- > 0){
    800002a0:	fed518e3          	bne	a0,a3,80000290 <memcmp+0x14>
  }

  return 0;
    800002a4:	4501                	li	a0,0
    800002a6:	a019                	j	800002ac <memcmp+0x30>
      return *s1 - *s2;
    800002a8:	40e7853b          	subw	a0,a5,a4
}
    800002ac:	6422                	ld	s0,8(sp)
    800002ae:	0141                	addi	sp,sp,16
    800002b0:	8082                	ret
  return 0;
    800002b2:	4501                	li	a0,0
    800002b4:	bfe5                	j	800002ac <memcmp+0x30>

00000000800002b6 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800002b6:	1141                	addi	sp,sp,-16
    800002b8:	e422                	sd	s0,8(sp)
    800002ba:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    800002bc:	ca0d                	beqz	a2,800002ee <memmove+0x38>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    800002be:	00a5f963          	bgeu	a1,a0,800002d0 <memmove+0x1a>
    800002c2:	02061693          	slli	a3,a2,0x20
    800002c6:	9281                	srli	a3,a3,0x20
    800002c8:	00d58733          	add	a4,a1,a3
    800002cc:	02e56463          	bltu	a0,a4,800002f4 <memmove+0x3e>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800002d0:	fff6079b          	addiw	a5,a2,-1
    800002d4:	1782                	slli	a5,a5,0x20
    800002d6:	9381                	srli	a5,a5,0x20
    800002d8:	0785                	addi	a5,a5,1
    800002da:	97ae                	add	a5,a5,a1
    800002dc:	872a                	mv	a4,a0
      *d++ = *s++;
    800002de:	0585                	addi	a1,a1,1
    800002e0:	0705                	addi	a4,a4,1
    800002e2:	fff5c683          	lbu	a3,-1(a1)
    800002e6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    800002ea:	fef59ae3          	bne	a1,a5,800002de <memmove+0x28>

  return dst;
}
    800002ee:	6422                	ld	s0,8(sp)
    800002f0:	0141                	addi	sp,sp,16
    800002f2:	8082                	ret
    d += n;
    800002f4:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    800002f6:	fff6079b          	addiw	a5,a2,-1
    800002fa:	1782                	slli	a5,a5,0x20
    800002fc:	9381                	srli	a5,a5,0x20
    800002fe:	fff7c793          	not	a5,a5
    80000302:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000304:	177d                	addi	a4,a4,-1
    80000306:	16fd                	addi	a3,a3,-1
    80000308:	00074603          	lbu	a2,0(a4)
    8000030c:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000310:	fef71ae3          	bne	a4,a5,80000304 <memmove+0x4e>
    80000314:	bfe9                	j	800002ee <memmove+0x38>

0000000080000316 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000316:	1141                	addi	sp,sp,-16
    80000318:	e406                	sd	ra,8(sp)
    8000031a:	e022                	sd	s0,0(sp)
    8000031c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    8000031e:	00000097          	auipc	ra,0x0
    80000322:	f98080e7          	jalr	-104(ra) # 800002b6 <memmove>
}
    80000326:	60a2                	ld	ra,8(sp)
    80000328:	6402                	ld	s0,0(sp)
    8000032a:	0141                	addi	sp,sp,16
    8000032c:	8082                	ret

000000008000032e <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    8000032e:	1141                	addi	sp,sp,-16
    80000330:	e422                	sd	s0,8(sp)
    80000332:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000334:	ce11                	beqz	a2,80000350 <strncmp+0x22>
    80000336:	00054783          	lbu	a5,0(a0)
    8000033a:	cf89                	beqz	a5,80000354 <strncmp+0x26>
    8000033c:	0005c703          	lbu	a4,0(a1)
    80000340:	00f71a63          	bne	a4,a5,80000354 <strncmp+0x26>
    n--, p++, q++;
    80000344:	367d                	addiw	a2,a2,-1
    80000346:	0505                	addi	a0,a0,1
    80000348:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    8000034a:	f675                	bnez	a2,80000336 <strncmp+0x8>
  if(n == 0)
    return 0;
    8000034c:	4501                	li	a0,0
    8000034e:	a809                	j	80000360 <strncmp+0x32>
    80000350:	4501                	li	a0,0
    80000352:	a039                	j	80000360 <strncmp+0x32>
  if(n == 0)
    80000354:	ca09                	beqz	a2,80000366 <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    80000356:	00054503          	lbu	a0,0(a0)
    8000035a:	0005c783          	lbu	a5,0(a1)
    8000035e:	9d1d                	subw	a0,a0,a5
}
    80000360:	6422                	ld	s0,8(sp)
    80000362:	0141                	addi	sp,sp,16
    80000364:	8082                	ret
    return 0;
    80000366:	4501                	li	a0,0
    80000368:	bfe5                	j	80000360 <strncmp+0x32>

000000008000036a <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    8000036a:	1141                	addi	sp,sp,-16
    8000036c:	e422                	sd	s0,8(sp)
    8000036e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000370:	872a                	mv	a4,a0
    80000372:	8832                	mv	a6,a2
    80000374:	367d                	addiw	a2,a2,-1
    80000376:	01005963          	blez	a6,80000388 <strncpy+0x1e>
    8000037a:	0705                	addi	a4,a4,1
    8000037c:	0005c783          	lbu	a5,0(a1)
    80000380:	fef70fa3          	sb	a5,-1(a4)
    80000384:	0585                	addi	a1,a1,1
    80000386:	f7f5                	bnez	a5,80000372 <strncpy+0x8>
    ;
  while(n-- > 0)
    80000388:	00c05d63          	blez	a2,800003a2 <strncpy+0x38>
    8000038c:	86ba                	mv	a3,a4
    *s++ = 0;
    8000038e:	0685                	addi	a3,a3,1
    80000390:	fe068fa3          	sb	zero,-1(a3)
  while(n-- > 0)
    80000394:	fff6c793          	not	a5,a3
    80000398:	9fb9                	addw	a5,a5,a4
    8000039a:	010787bb          	addw	a5,a5,a6
    8000039e:	fef048e3          	bgtz	a5,8000038e <strncpy+0x24>
  return os;
}
    800003a2:	6422                	ld	s0,8(sp)
    800003a4:	0141                	addi	sp,sp,16
    800003a6:	8082                	ret

00000000800003a8 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800003a8:	1141                	addi	sp,sp,-16
    800003aa:	e422                	sd	s0,8(sp)
    800003ac:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800003ae:	02c05363          	blez	a2,800003d4 <safestrcpy+0x2c>
    800003b2:	fff6069b          	addiw	a3,a2,-1
    800003b6:	1682                	slli	a3,a3,0x20
    800003b8:	9281                	srli	a3,a3,0x20
    800003ba:	96ae                	add	a3,a3,a1
    800003bc:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800003be:	00d58963          	beq	a1,a3,800003d0 <safestrcpy+0x28>
    800003c2:	0585                	addi	a1,a1,1
    800003c4:	0785                	addi	a5,a5,1
    800003c6:	fff5c703          	lbu	a4,-1(a1)
    800003ca:	fee78fa3          	sb	a4,-1(a5)
    800003ce:	fb65                	bnez	a4,800003be <safestrcpy+0x16>
    ;
  *s = 0;
    800003d0:	00078023          	sb	zero,0(a5)
  return os;
}
    800003d4:	6422                	ld	s0,8(sp)
    800003d6:	0141                	addi	sp,sp,16
    800003d8:	8082                	ret

00000000800003da <strlen>:

int
strlen(const char *s)
{
    800003da:	1141                	addi	sp,sp,-16
    800003dc:	e422                	sd	s0,8(sp)
    800003de:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    800003e0:	00054783          	lbu	a5,0(a0)
    800003e4:	cf91                	beqz	a5,80000400 <strlen+0x26>
    800003e6:	0505                	addi	a0,a0,1
    800003e8:	87aa                	mv	a5,a0
    800003ea:	4685                	li	a3,1
    800003ec:	9e89                	subw	a3,a3,a0
    800003ee:	00f6853b          	addw	a0,a3,a5
    800003f2:	0785                	addi	a5,a5,1
    800003f4:	fff7c703          	lbu	a4,-1(a5)
    800003f8:	fb7d                	bnez	a4,800003ee <strlen+0x14>
    ;
  return n;
}
    800003fa:	6422                	ld	s0,8(sp)
    800003fc:	0141                	addi	sp,sp,16
    800003fe:	8082                	ret
  for(n = 0; s[n]; n++)
    80000400:	4501                	li	a0,0
    80000402:	bfe5                	j	800003fa <strlen+0x20>

0000000080000404 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000404:	1101                	addi	sp,sp,-32
    80000406:	ec06                	sd	ra,24(sp)
    80000408:	e822                	sd	s0,16(sp)
    8000040a:	e426                	sd	s1,8(sp)
    8000040c:	1000                	addi	s0,sp,32
  if(cpuid() == 0){
    8000040e:	00001097          	auipc	ra,0x1
    80000412:	afc080e7          	jalr	-1284(ra) # 80000f0a <cpuid>
    kcsaninit();
#endif
    __sync_synchronize();
    started = 1;
  } else {
    while(lockfree_read4((int *) &started) == 0)
    80000416:	00009497          	auipc	s1,0x9
    8000041a:	bea48493          	addi	s1,s1,-1046 # 80009000 <started>
  if(cpuid() == 0){
    8000041e:	c531                	beqz	a0,8000046a <main+0x66>
    while(lockfree_read4((int *) &started) == 0)
    80000420:	8526                	mv	a0,s1
    80000422:	00006097          	auipc	ra,0x6
    80000426:	450080e7          	jalr	1104(ra) # 80006872 <lockfree_read4>
    8000042a:	d97d                	beqz	a0,80000420 <main+0x1c>
      ;
    __sync_synchronize();
    8000042c:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    80000430:	00001097          	auipc	ra,0x1
    80000434:	ada080e7          	jalr	-1318(ra) # 80000f0a <cpuid>
    80000438:	85aa                	mv	a1,a0
    8000043a:	00008517          	auipc	a0,0x8
    8000043e:	bfe50513          	addi	a0,a0,-1026 # 80008038 <etext+0x38>
    80000442:	00006097          	auipc	ra,0x6
    80000446:	d34080e7          	jalr	-716(ra) # 80006176 <printf>
    kvminithart();    // turn on paging
    8000044a:	00000097          	auipc	ra,0x0
    8000044e:	0e0080e7          	jalr	224(ra) # 8000052a <kvminithart>
    trapinithart();   // install kernel trap vector
    80000452:	00001097          	auipc	ra,0x1
    80000456:	730080e7          	jalr	1840(ra) # 80001b82 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    8000045a:	00005097          	auipc	ra,0x5
    8000045e:	e76080e7          	jalr	-394(ra) # 800052d0 <plicinithart>
  }

  scheduler();        
    80000462:	00001097          	auipc	ra,0x1
    80000466:	fde080e7          	jalr	-34(ra) # 80001440 <scheduler>
    consoleinit();
    8000046a:	00006097          	auipc	ra,0x6
    8000046e:	bd4080e7          	jalr	-1068(ra) # 8000603e <consoleinit>
    statsinit();
    80000472:	00005097          	auipc	ra,0x5
    80000476:	544080e7          	jalr	1348(ra) # 800059b6 <statsinit>
    printfinit();
    8000047a:	00006097          	auipc	ra,0x6
    8000047e:	ee2080e7          	jalr	-286(ra) # 8000635c <printfinit>
    printf("\n");
    80000482:	00008517          	auipc	a0,0x8
    80000486:	3e650513          	addi	a0,a0,998 # 80008868 <digits+0x88>
    8000048a:	00006097          	auipc	ra,0x6
    8000048e:	cec080e7          	jalr	-788(ra) # 80006176 <printf>
    printf("xv6 kernel is booting\n");
    80000492:	00008517          	auipc	a0,0x8
    80000496:	b8e50513          	addi	a0,a0,-1138 # 80008020 <etext+0x20>
    8000049a:	00006097          	auipc	ra,0x6
    8000049e:	cdc080e7          	jalr	-804(ra) # 80006176 <printf>
    printf("\n");
    800004a2:	00008517          	auipc	a0,0x8
    800004a6:	3c650513          	addi	a0,a0,966 # 80008868 <digits+0x88>
    800004aa:	00006097          	auipc	ra,0x6
    800004ae:	ccc080e7          	jalr	-820(ra) # 80006176 <printf>
    kinit();         // physical page allocator
    800004b2:	00000097          	auipc	ra,0x0
    800004b6:	c5e080e7          	jalr	-930(ra) # 80000110 <kinit>
    kvminit();       // create kernel page table
    800004ba:	00000097          	auipc	ra,0x0
    800004be:	322080e7          	jalr	802(ra) # 800007dc <kvminit>
    kvminithart();   // turn on paging
    800004c2:	00000097          	auipc	ra,0x0
    800004c6:	068080e7          	jalr	104(ra) # 8000052a <kvminithart>
    procinit();      // process table
    800004ca:	00001097          	auipc	ra,0x1
    800004ce:	990080e7          	jalr	-1648(ra) # 80000e5a <procinit>
    trapinit();      // trap vectors
    800004d2:	00001097          	auipc	ra,0x1
    800004d6:	688080e7          	jalr	1672(ra) # 80001b5a <trapinit>
    trapinithart();  // install kernel trap vector
    800004da:	00001097          	auipc	ra,0x1
    800004de:	6a8080e7          	jalr	1704(ra) # 80001b82 <trapinithart>
    plicinit();      // set up interrupt controller
    800004e2:	00005097          	auipc	ra,0x5
    800004e6:	dd8080e7          	jalr	-552(ra) # 800052ba <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    800004ea:	00005097          	auipc	ra,0x5
    800004ee:	de6080e7          	jalr	-538(ra) # 800052d0 <plicinithart>
    binit();         // buffer cache
    800004f2:	00002097          	auipc	ra,0x2
    800004f6:	dd2080e7          	jalr	-558(ra) # 800022c4 <binit>
    iinit();         // inode table
    800004fa:	00002097          	auipc	ra,0x2
    800004fe:	64a080e7          	jalr	1610(ra) # 80002b44 <iinit>
    fileinit();      // file table
    80000502:	00003097          	auipc	ra,0x3
    80000506:	5f4080e7          	jalr	1524(ra) # 80003af6 <fileinit>
    virtio_disk_init(); // emulated hard disk
    8000050a:	00005097          	auipc	ra,0x5
    8000050e:	ee8080e7          	jalr	-280(ra) # 800053f2 <virtio_disk_init>
    userinit();      // first user process
    80000512:	00001097          	auipc	ra,0x1
    80000516:	cfc080e7          	jalr	-772(ra) # 8000120e <userinit>
    __sync_synchronize();
    8000051a:	0ff0000f          	fence
    started = 1;
    8000051e:	4785                	li	a5,1
    80000520:	00009717          	auipc	a4,0x9
    80000524:	aef72023          	sw	a5,-1312(a4) # 80009000 <started>
    80000528:	bf2d                	j	80000462 <main+0x5e>

000000008000052a <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    8000052a:	1141                	addi	sp,sp,-16
    8000052c:	e422                	sd	s0,8(sp)
    8000052e:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    80000530:	00009797          	auipc	a5,0x9
    80000534:	ad87b783          	ld	a5,-1320(a5) # 80009008 <kernel_pagetable>
    80000538:	83b1                	srli	a5,a5,0xc
    8000053a:	577d                	li	a4,-1
    8000053c:	177e                	slli	a4,a4,0x3f
    8000053e:	8fd9                	or	a5,a5,a4
// supervisor address translation and protection;
// holds the address of the page table.
static inline void 
w_satp(uint64 x)
{
  asm volatile("csrw satp, %0" : : "r" (x));
    80000540:	18079073          	csrw	satp,a5
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000544:	12000073          	sfence.vma
  sfence_vma();
}
    80000548:	6422                	ld	s0,8(sp)
    8000054a:	0141                	addi	sp,sp,16
    8000054c:	8082                	ret

000000008000054e <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    8000054e:	7139                	addi	sp,sp,-64
    80000550:	fc06                	sd	ra,56(sp)
    80000552:	f822                	sd	s0,48(sp)
    80000554:	f426                	sd	s1,40(sp)
    80000556:	f04a                	sd	s2,32(sp)
    80000558:	ec4e                	sd	s3,24(sp)
    8000055a:	e852                	sd	s4,16(sp)
    8000055c:	e456                	sd	s5,8(sp)
    8000055e:	e05a                	sd	s6,0(sp)
    80000560:	0080                	addi	s0,sp,64
    80000562:	84aa                	mv	s1,a0
    80000564:	89ae                	mv	s3,a1
    80000566:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    80000568:	57fd                	li	a5,-1
    8000056a:	83e9                	srli	a5,a5,0x1a
    8000056c:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    8000056e:	4b31                	li	s6,12
  if(va >= MAXVA)
    80000570:	04b7f263          	bgeu	a5,a1,800005b4 <walk+0x66>
    panic("walk");
    80000574:	00008517          	auipc	a0,0x8
    80000578:	adc50513          	addi	a0,a0,-1316 # 80008050 <etext+0x50>
    8000057c:	00006097          	auipc	ra,0x6
    80000580:	bb0080e7          	jalr	-1104(ra) # 8000612c <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80000584:	060a8663          	beqz	s5,800005f0 <walk+0xa2>
    80000588:	00000097          	auipc	ra,0x0
    8000058c:	be4080e7          	jalr	-1052(ra) # 8000016c <kalloc>
    80000590:	84aa                	mv	s1,a0
    80000592:	c529                	beqz	a0,800005dc <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    80000594:	6605                	lui	a2,0x1
    80000596:	4581                	li	a1,0
    80000598:	00000097          	auipc	ra,0x0
    8000059c:	cbe080e7          	jalr	-834(ra) # 80000256 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    800005a0:	00c4d793          	srli	a5,s1,0xc
    800005a4:	07aa                	slli	a5,a5,0xa
    800005a6:	0017e793          	ori	a5,a5,1
    800005aa:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    800005ae:	3a5d                	addiw	s4,s4,-9
    800005b0:	036a0063          	beq	s4,s6,800005d0 <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    800005b4:	0149d933          	srl	s2,s3,s4
    800005b8:	1ff97913          	andi	s2,s2,511
    800005bc:	090e                	slli	s2,s2,0x3
    800005be:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    800005c0:	00093483          	ld	s1,0(s2)
    800005c4:	0014f793          	andi	a5,s1,1
    800005c8:	dfd5                	beqz	a5,80000584 <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    800005ca:	80a9                	srli	s1,s1,0xa
    800005cc:	04b2                	slli	s1,s1,0xc
    800005ce:	b7c5                	j	800005ae <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    800005d0:	00c9d513          	srli	a0,s3,0xc
    800005d4:	1ff57513          	andi	a0,a0,511
    800005d8:	050e                	slli	a0,a0,0x3
    800005da:	9526                	add	a0,a0,s1
}
    800005dc:	70e2                	ld	ra,56(sp)
    800005de:	7442                	ld	s0,48(sp)
    800005e0:	74a2                	ld	s1,40(sp)
    800005e2:	7902                	ld	s2,32(sp)
    800005e4:	69e2                	ld	s3,24(sp)
    800005e6:	6a42                	ld	s4,16(sp)
    800005e8:	6aa2                	ld	s5,8(sp)
    800005ea:	6b02                	ld	s6,0(sp)
    800005ec:	6121                	addi	sp,sp,64
    800005ee:	8082                	ret
        return 0;
    800005f0:	4501                	li	a0,0
    800005f2:	b7ed                	j	800005dc <walk+0x8e>

00000000800005f4 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    800005f4:	57fd                	li	a5,-1
    800005f6:	83e9                	srli	a5,a5,0x1a
    800005f8:	00b7f463          	bgeu	a5,a1,80000600 <walkaddr+0xc>
    return 0;
    800005fc:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    800005fe:	8082                	ret
{
    80000600:	1141                	addi	sp,sp,-16
    80000602:	e406                	sd	ra,8(sp)
    80000604:	e022                	sd	s0,0(sp)
    80000606:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80000608:	4601                	li	a2,0
    8000060a:	00000097          	auipc	ra,0x0
    8000060e:	f44080e7          	jalr	-188(ra) # 8000054e <walk>
  if(pte == 0)
    80000612:	c105                	beqz	a0,80000632 <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    80000614:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    80000616:	0117f693          	andi	a3,a5,17
    8000061a:	4745                	li	a4,17
    return 0;
    8000061c:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    8000061e:	00e68663          	beq	a3,a4,8000062a <walkaddr+0x36>
}
    80000622:	60a2                	ld	ra,8(sp)
    80000624:	6402                	ld	s0,0(sp)
    80000626:	0141                	addi	sp,sp,16
    80000628:	8082                	ret
  pa = PTE2PA(*pte);
    8000062a:	00a7d513          	srli	a0,a5,0xa
    8000062e:	0532                	slli	a0,a0,0xc
  return pa;
    80000630:	bfcd                	j	80000622 <walkaddr+0x2e>
    return 0;
    80000632:	4501                	li	a0,0
    80000634:	b7fd                	j	80000622 <walkaddr+0x2e>

0000000080000636 <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80000636:	715d                	addi	sp,sp,-80
    80000638:	e486                	sd	ra,72(sp)
    8000063a:	e0a2                	sd	s0,64(sp)
    8000063c:	fc26                	sd	s1,56(sp)
    8000063e:	f84a                	sd	s2,48(sp)
    80000640:	f44e                	sd	s3,40(sp)
    80000642:	f052                	sd	s4,32(sp)
    80000644:	ec56                	sd	s5,24(sp)
    80000646:	e85a                	sd	s6,16(sp)
    80000648:	e45e                	sd	s7,8(sp)
    8000064a:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    8000064c:	c205                	beqz	a2,8000066c <mappages+0x36>
    8000064e:	8aaa                	mv	s5,a0
    80000650:	8b3a                	mv	s6,a4
    panic("mappages: size");
  
  a = PGROUNDDOWN(va);
    80000652:	77fd                	lui	a5,0xfffff
    80000654:	00f5fa33          	and	s4,a1,a5
  last = PGROUNDDOWN(va + size - 1);
    80000658:	15fd                	addi	a1,a1,-1
    8000065a:	00c589b3          	add	s3,a1,a2
    8000065e:	00f9f9b3          	and	s3,s3,a5
  a = PGROUNDDOWN(va);
    80000662:	8952                	mv	s2,s4
    80000664:	41468a33          	sub	s4,a3,s4
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    80000668:	6b85                	lui	s7,0x1
    8000066a:	a015                	j	8000068e <mappages+0x58>
    panic("mappages: size");
    8000066c:	00008517          	auipc	a0,0x8
    80000670:	9ec50513          	addi	a0,a0,-1556 # 80008058 <etext+0x58>
    80000674:	00006097          	auipc	ra,0x6
    80000678:	ab8080e7          	jalr	-1352(ra) # 8000612c <panic>
      panic("mappages: remap");
    8000067c:	00008517          	auipc	a0,0x8
    80000680:	9ec50513          	addi	a0,a0,-1556 # 80008068 <etext+0x68>
    80000684:	00006097          	auipc	ra,0x6
    80000688:	aa8080e7          	jalr	-1368(ra) # 8000612c <panic>
    a += PGSIZE;
    8000068c:	995e                	add	s2,s2,s7
  for(;;){
    8000068e:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    80000692:	4605                	li	a2,1
    80000694:	85ca                	mv	a1,s2
    80000696:	8556                	mv	a0,s5
    80000698:	00000097          	auipc	ra,0x0
    8000069c:	eb6080e7          	jalr	-330(ra) # 8000054e <walk>
    800006a0:	cd19                	beqz	a0,800006be <mappages+0x88>
    if(*pte & PTE_V)
    800006a2:	611c                	ld	a5,0(a0)
    800006a4:	8b85                	andi	a5,a5,1
    800006a6:	fbf9                	bnez	a5,8000067c <mappages+0x46>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800006a8:	80b1                	srli	s1,s1,0xc
    800006aa:	04aa                	slli	s1,s1,0xa
    800006ac:	0164e4b3          	or	s1,s1,s6
    800006b0:	0014e493          	ori	s1,s1,1
    800006b4:	e104                	sd	s1,0(a0)
    if(a == last)
    800006b6:	fd391be3          	bne	s2,s3,8000068c <mappages+0x56>
    pa += PGSIZE;
  }
  return 0;
    800006ba:	4501                	li	a0,0
    800006bc:	a011                	j	800006c0 <mappages+0x8a>
      return -1;
    800006be:	557d                	li	a0,-1
}
    800006c0:	60a6                	ld	ra,72(sp)
    800006c2:	6406                	ld	s0,64(sp)
    800006c4:	74e2                	ld	s1,56(sp)
    800006c6:	7942                	ld	s2,48(sp)
    800006c8:	79a2                	ld	s3,40(sp)
    800006ca:	7a02                	ld	s4,32(sp)
    800006cc:	6ae2                	ld	s5,24(sp)
    800006ce:	6b42                	ld	s6,16(sp)
    800006d0:	6ba2                	ld	s7,8(sp)
    800006d2:	6161                	addi	sp,sp,80
    800006d4:	8082                	ret

00000000800006d6 <kvmmap>:
{
    800006d6:	1141                	addi	sp,sp,-16
    800006d8:	e406                	sd	ra,8(sp)
    800006da:	e022                	sd	s0,0(sp)
    800006dc:	0800                	addi	s0,sp,16
    800006de:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    800006e0:	86b2                	mv	a3,a2
    800006e2:	863e                	mv	a2,a5
    800006e4:	00000097          	auipc	ra,0x0
    800006e8:	f52080e7          	jalr	-174(ra) # 80000636 <mappages>
    800006ec:	e509                	bnez	a0,800006f6 <kvmmap+0x20>
}
    800006ee:	60a2                	ld	ra,8(sp)
    800006f0:	6402                	ld	s0,0(sp)
    800006f2:	0141                	addi	sp,sp,16
    800006f4:	8082                	ret
    panic("kvmmap");
    800006f6:	00008517          	auipc	a0,0x8
    800006fa:	98250513          	addi	a0,a0,-1662 # 80008078 <etext+0x78>
    800006fe:	00006097          	auipc	ra,0x6
    80000702:	a2e080e7          	jalr	-1490(ra) # 8000612c <panic>

0000000080000706 <kvmmake>:
{
    80000706:	1101                	addi	sp,sp,-32
    80000708:	ec06                	sd	ra,24(sp)
    8000070a:	e822                	sd	s0,16(sp)
    8000070c:	e426                	sd	s1,8(sp)
    8000070e:	e04a                	sd	s2,0(sp)
    80000710:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    80000712:	00000097          	auipc	ra,0x0
    80000716:	a5a080e7          	jalr	-1446(ra) # 8000016c <kalloc>
    8000071a:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    8000071c:	6605                	lui	a2,0x1
    8000071e:	4581                	li	a1,0
    80000720:	00000097          	auipc	ra,0x0
    80000724:	b36080e7          	jalr	-1226(ra) # 80000256 <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80000728:	4719                	li	a4,6
    8000072a:	6685                	lui	a3,0x1
    8000072c:	10000637          	lui	a2,0x10000
    80000730:	100005b7          	lui	a1,0x10000
    80000734:	8526                	mv	a0,s1
    80000736:	00000097          	auipc	ra,0x0
    8000073a:	fa0080e7          	jalr	-96(ra) # 800006d6 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    8000073e:	4719                	li	a4,6
    80000740:	6685                	lui	a3,0x1
    80000742:	10001637          	lui	a2,0x10001
    80000746:	100015b7          	lui	a1,0x10001
    8000074a:	8526                	mv	a0,s1
    8000074c:	00000097          	auipc	ra,0x0
    80000750:	f8a080e7          	jalr	-118(ra) # 800006d6 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80000754:	4719                	li	a4,6
    80000756:	004006b7          	lui	a3,0x400
    8000075a:	0c000637          	lui	a2,0xc000
    8000075e:	0c0005b7          	lui	a1,0xc000
    80000762:	8526                	mv	a0,s1
    80000764:	00000097          	auipc	ra,0x0
    80000768:	f72080e7          	jalr	-142(ra) # 800006d6 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    8000076c:	00008917          	auipc	s2,0x8
    80000770:	89490913          	addi	s2,s2,-1900 # 80008000 <etext>
    80000774:	4729                	li	a4,10
    80000776:	80008697          	auipc	a3,0x80008
    8000077a:	88a68693          	addi	a3,a3,-1910 # 8000 <_entry-0x7fff8000>
    8000077e:	4605                	li	a2,1
    80000780:	067e                	slli	a2,a2,0x1f
    80000782:	85b2                	mv	a1,a2
    80000784:	8526                	mv	a0,s1
    80000786:	00000097          	auipc	ra,0x0
    8000078a:	f50080e7          	jalr	-176(ra) # 800006d6 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    8000078e:	4719                	li	a4,6
    80000790:	46c5                	li	a3,17
    80000792:	06ee                	slli	a3,a3,0x1b
    80000794:	412686b3          	sub	a3,a3,s2
    80000798:	864a                	mv	a2,s2
    8000079a:	85ca                	mv	a1,s2
    8000079c:	8526                	mv	a0,s1
    8000079e:	00000097          	auipc	ra,0x0
    800007a2:	f38080e7          	jalr	-200(ra) # 800006d6 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800007a6:	4729                	li	a4,10
    800007a8:	6685                	lui	a3,0x1
    800007aa:	00007617          	auipc	a2,0x7
    800007ae:	85660613          	addi	a2,a2,-1962 # 80007000 <_trampoline>
    800007b2:	040005b7          	lui	a1,0x4000
    800007b6:	15fd                	addi	a1,a1,-1
    800007b8:	05b2                	slli	a1,a1,0xc
    800007ba:	8526                	mv	a0,s1
    800007bc:	00000097          	auipc	ra,0x0
    800007c0:	f1a080e7          	jalr	-230(ra) # 800006d6 <kvmmap>
  proc_mapstacks(kpgtbl);
    800007c4:	8526                	mv	a0,s1
    800007c6:	00000097          	auipc	ra,0x0
    800007ca:	5fe080e7          	jalr	1534(ra) # 80000dc4 <proc_mapstacks>
}
    800007ce:	8526                	mv	a0,s1
    800007d0:	60e2                	ld	ra,24(sp)
    800007d2:	6442                	ld	s0,16(sp)
    800007d4:	64a2                	ld	s1,8(sp)
    800007d6:	6902                	ld	s2,0(sp)
    800007d8:	6105                	addi	sp,sp,32
    800007da:	8082                	ret

00000000800007dc <kvminit>:
{
    800007dc:	1141                	addi	sp,sp,-16
    800007de:	e406                	sd	ra,8(sp)
    800007e0:	e022                	sd	s0,0(sp)
    800007e2:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    800007e4:	00000097          	auipc	ra,0x0
    800007e8:	f22080e7          	jalr	-222(ra) # 80000706 <kvmmake>
    800007ec:	00009797          	auipc	a5,0x9
    800007f0:	80a7be23          	sd	a0,-2020(a5) # 80009008 <kernel_pagetable>
}
    800007f4:	60a2                	ld	ra,8(sp)
    800007f6:	6402                	ld	s0,0(sp)
    800007f8:	0141                	addi	sp,sp,16
    800007fa:	8082                	ret

00000000800007fc <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    800007fc:	715d                	addi	sp,sp,-80
    800007fe:	e486                	sd	ra,72(sp)
    80000800:	e0a2                	sd	s0,64(sp)
    80000802:	fc26                	sd	s1,56(sp)
    80000804:	f84a                	sd	s2,48(sp)
    80000806:	f44e                	sd	s3,40(sp)
    80000808:	f052                	sd	s4,32(sp)
    8000080a:	ec56                	sd	s5,24(sp)
    8000080c:	e85a                	sd	s6,16(sp)
    8000080e:	e45e                	sd	s7,8(sp)
    80000810:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80000812:	03459793          	slli	a5,a1,0x34
    80000816:	e795                	bnez	a5,80000842 <uvmunmap+0x46>
    80000818:	8a2a                	mv	s4,a0
    8000081a:	892e                	mv	s2,a1
    8000081c:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000081e:	0632                	slli	a2,a2,0xc
    80000820:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    80000824:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000826:	6b05                	lui	s6,0x1
    80000828:	0735e863          	bltu	a1,s3,80000898 <uvmunmap+0x9c>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    8000082c:	60a6                	ld	ra,72(sp)
    8000082e:	6406                	ld	s0,64(sp)
    80000830:	74e2                	ld	s1,56(sp)
    80000832:	7942                	ld	s2,48(sp)
    80000834:	79a2                	ld	s3,40(sp)
    80000836:	7a02                	ld	s4,32(sp)
    80000838:	6ae2                	ld	s5,24(sp)
    8000083a:	6b42                	ld	s6,16(sp)
    8000083c:	6ba2                	ld	s7,8(sp)
    8000083e:	6161                	addi	sp,sp,80
    80000840:	8082                	ret
    panic("uvmunmap: not aligned");
    80000842:	00008517          	auipc	a0,0x8
    80000846:	83e50513          	addi	a0,a0,-1986 # 80008080 <etext+0x80>
    8000084a:	00006097          	auipc	ra,0x6
    8000084e:	8e2080e7          	jalr	-1822(ra) # 8000612c <panic>
      panic("uvmunmap: walk");
    80000852:	00008517          	auipc	a0,0x8
    80000856:	84650513          	addi	a0,a0,-1978 # 80008098 <etext+0x98>
    8000085a:	00006097          	auipc	ra,0x6
    8000085e:	8d2080e7          	jalr	-1838(ra) # 8000612c <panic>
      panic("uvmunmap: not mapped");
    80000862:	00008517          	auipc	a0,0x8
    80000866:	84650513          	addi	a0,a0,-1978 # 800080a8 <etext+0xa8>
    8000086a:	00006097          	auipc	ra,0x6
    8000086e:	8c2080e7          	jalr	-1854(ra) # 8000612c <panic>
      panic("uvmunmap: not a leaf");
    80000872:	00008517          	auipc	a0,0x8
    80000876:	84e50513          	addi	a0,a0,-1970 # 800080c0 <etext+0xc0>
    8000087a:	00006097          	auipc	ra,0x6
    8000087e:	8b2080e7          	jalr	-1870(ra) # 8000612c <panic>
      uint64 pa = PTE2PA(*pte);
    80000882:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    80000884:	0532                	slli	a0,a0,0xc
    80000886:	fffff097          	auipc	ra,0xfffff
    8000088a:	796080e7          	jalr	1942(ra) # 8000001c <kfree>
    *pte = 0;
    8000088e:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000892:	995a                	add	s2,s2,s6
    80000894:	f9397ce3          	bgeu	s2,s3,8000082c <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    80000898:	4601                	li	a2,0
    8000089a:	85ca                	mv	a1,s2
    8000089c:	8552                	mv	a0,s4
    8000089e:	00000097          	auipc	ra,0x0
    800008a2:	cb0080e7          	jalr	-848(ra) # 8000054e <walk>
    800008a6:	84aa                	mv	s1,a0
    800008a8:	d54d                	beqz	a0,80000852 <uvmunmap+0x56>
    if((*pte & PTE_V) == 0)
    800008aa:	6108                	ld	a0,0(a0)
    800008ac:	00157793          	andi	a5,a0,1
    800008b0:	dbcd                	beqz	a5,80000862 <uvmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    800008b2:	3ff57793          	andi	a5,a0,1023
    800008b6:	fb778ee3          	beq	a5,s7,80000872 <uvmunmap+0x76>
    if(do_free){
    800008ba:	fc0a8ae3          	beqz	s5,8000088e <uvmunmap+0x92>
    800008be:	b7d1                	j	80000882 <uvmunmap+0x86>

00000000800008c0 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    800008c0:	1101                	addi	sp,sp,-32
    800008c2:	ec06                	sd	ra,24(sp)
    800008c4:	e822                	sd	s0,16(sp)
    800008c6:	e426                	sd	s1,8(sp)
    800008c8:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    800008ca:	00000097          	auipc	ra,0x0
    800008ce:	8a2080e7          	jalr	-1886(ra) # 8000016c <kalloc>
    800008d2:	84aa                	mv	s1,a0
  if(pagetable == 0)
    800008d4:	c519                	beqz	a0,800008e2 <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    800008d6:	6605                	lui	a2,0x1
    800008d8:	4581                	li	a1,0
    800008da:	00000097          	auipc	ra,0x0
    800008de:	97c080e7          	jalr	-1668(ra) # 80000256 <memset>
  return pagetable;
}
    800008e2:	8526                	mv	a0,s1
    800008e4:	60e2                	ld	ra,24(sp)
    800008e6:	6442                	ld	s0,16(sp)
    800008e8:	64a2                	ld	s1,8(sp)
    800008ea:	6105                	addi	sp,sp,32
    800008ec:	8082                	ret

00000000800008ee <uvminit>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvminit(pagetable_t pagetable, uchar *src, uint sz)
{
    800008ee:	7179                	addi	sp,sp,-48
    800008f0:	f406                	sd	ra,40(sp)
    800008f2:	f022                	sd	s0,32(sp)
    800008f4:	ec26                	sd	s1,24(sp)
    800008f6:	e84a                	sd	s2,16(sp)
    800008f8:	e44e                	sd	s3,8(sp)
    800008fa:	e052                	sd	s4,0(sp)
    800008fc:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    800008fe:	6785                	lui	a5,0x1
    80000900:	04f67863          	bgeu	a2,a5,80000950 <uvminit+0x62>
    80000904:	8a2a                	mv	s4,a0
    80000906:	89ae                	mv	s3,a1
    80000908:	84b2                	mv	s1,a2
    panic("inituvm: more than a page");
  mem = kalloc();
    8000090a:	00000097          	auipc	ra,0x0
    8000090e:	862080e7          	jalr	-1950(ra) # 8000016c <kalloc>
    80000912:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    80000914:	6605                	lui	a2,0x1
    80000916:	4581                	li	a1,0
    80000918:	00000097          	auipc	ra,0x0
    8000091c:	93e080e7          	jalr	-1730(ra) # 80000256 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80000920:	4779                	li	a4,30
    80000922:	86ca                	mv	a3,s2
    80000924:	6605                	lui	a2,0x1
    80000926:	4581                	li	a1,0
    80000928:	8552                	mv	a0,s4
    8000092a:	00000097          	auipc	ra,0x0
    8000092e:	d0c080e7          	jalr	-756(ra) # 80000636 <mappages>
  memmove(mem, src, sz);
    80000932:	8626                	mv	a2,s1
    80000934:	85ce                	mv	a1,s3
    80000936:	854a                	mv	a0,s2
    80000938:	00000097          	auipc	ra,0x0
    8000093c:	97e080e7          	jalr	-1666(ra) # 800002b6 <memmove>
}
    80000940:	70a2                	ld	ra,40(sp)
    80000942:	7402                	ld	s0,32(sp)
    80000944:	64e2                	ld	s1,24(sp)
    80000946:	6942                	ld	s2,16(sp)
    80000948:	69a2                	ld	s3,8(sp)
    8000094a:	6a02                	ld	s4,0(sp)
    8000094c:	6145                	addi	sp,sp,48
    8000094e:	8082                	ret
    panic("inituvm: more than a page");
    80000950:	00007517          	auipc	a0,0x7
    80000954:	78850513          	addi	a0,a0,1928 # 800080d8 <etext+0xd8>
    80000958:	00005097          	auipc	ra,0x5
    8000095c:	7d4080e7          	jalr	2004(ra) # 8000612c <panic>

0000000080000960 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    80000960:	1101                	addi	sp,sp,-32
    80000962:	ec06                	sd	ra,24(sp)
    80000964:	e822                	sd	s0,16(sp)
    80000966:	e426                	sd	s1,8(sp)
    80000968:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    8000096a:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    8000096c:	00b67d63          	bgeu	a2,a1,80000986 <uvmdealloc+0x26>
    80000970:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80000972:	6785                	lui	a5,0x1
    80000974:	17fd                	addi	a5,a5,-1
    80000976:	00f60733          	add	a4,a2,a5
    8000097a:	767d                	lui	a2,0xfffff
    8000097c:	8f71                	and	a4,a4,a2
    8000097e:	97ae                	add	a5,a5,a1
    80000980:	8ff1                	and	a5,a5,a2
    80000982:	00f76863          	bltu	a4,a5,80000992 <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    80000986:	8526                	mv	a0,s1
    80000988:	60e2                	ld	ra,24(sp)
    8000098a:	6442                	ld	s0,16(sp)
    8000098c:	64a2                	ld	s1,8(sp)
    8000098e:	6105                	addi	sp,sp,32
    80000990:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80000992:	8f99                	sub	a5,a5,a4
    80000994:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    80000996:	4685                	li	a3,1
    80000998:	0007861b          	sext.w	a2,a5
    8000099c:	85ba                	mv	a1,a4
    8000099e:	00000097          	auipc	ra,0x0
    800009a2:	e5e080e7          	jalr	-418(ra) # 800007fc <uvmunmap>
    800009a6:	b7c5                	j	80000986 <uvmdealloc+0x26>

00000000800009a8 <uvmalloc>:
  if(newsz < oldsz)
    800009a8:	0ab66163          	bltu	a2,a1,80000a4a <uvmalloc+0xa2>
{
    800009ac:	7139                	addi	sp,sp,-64
    800009ae:	fc06                	sd	ra,56(sp)
    800009b0:	f822                	sd	s0,48(sp)
    800009b2:	f426                	sd	s1,40(sp)
    800009b4:	f04a                	sd	s2,32(sp)
    800009b6:	ec4e                	sd	s3,24(sp)
    800009b8:	e852                	sd	s4,16(sp)
    800009ba:	e456                	sd	s5,8(sp)
    800009bc:	0080                	addi	s0,sp,64
    800009be:	8aaa                	mv	s5,a0
    800009c0:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    800009c2:	6985                	lui	s3,0x1
    800009c4:	19fd                	addi	s3,s3,-1
    800009c6:	95ce                	add	a1,a1,s3
    800009c8:	79fd                	lui	s3,0xfffff
    800009ca:	0135f9b3          	and	s3,a1,s3
  for(a = oldsz; a < newsz; a += PGSIZE){
    800009ce:	08c9f063          	bgeu	s3,a2,80000a4e <uvmalloc+0xa6>
    800009d2:	894e                	mv	s2,s3
    mem = kalloc();
    800009d4:	fffff097          	auipc	ra,0xfffff
    800009d8:	798080e7          	jalr	1944(ra) # 8000016c <kalloc>
    800009dc:	84aa                	mv	s1,a0
    if(mem == 0){
    800009de:	c51d                	beqz	a0,80000a0c <uvmalloc+0x64>
    memset(mem, 0, PGSIZE);
    800009e0:	6605                	lui	a2,0x1
    800009e2:	4581                	li	a1,0
    800009e4:	00000097          	auipc	ra,0x0
    800009e8:	872080e7          	jalr	-1934(ra) # 80000256 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    800009ec:	4779                	li	a4,30
    800009ee:	86a6                	mv	a3,s1
    800009f0:	6605                	lui	a2,0x1
    800009f2:	85ca                	mv	a1,s2
    800009f4:	8556                	mv	a0,s5
    800009f6:	00000097          	auipc	ra,0x0
    800009fa:	c40080e7          	jalr	-960(ra) # 80000636 <mappages>
    800009fe:	e905                	bnez	a0,80000a2e <uvmalloc+0x86>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000a00:	6785                	lui	a5,0x1
    80000a02:	993e                	add	s2,s2,a5
    80000a04:	fd4968e3          	bltu	s2,s4,800009d4 <uvmalloc+0x2c>
  return newsz;
    80000a08:	8552                	mv	a0,s4
    80000a0a:	a809                	j	80000a1c <uvmalloc+0x74>
      uvmdealloc(pagetable, a, oldsz);
    80000a0c:	864e                	mv	a2,s3
    80000a0e:	85ca                	mv	a1,s2
    80000a10:	8556                	mv	a0,s5
    80000a12:	00000097          	auipc	ra,0x0
    80000a16:	f4e080e7          	jalr	-178(ra) # 80000960 <uvmdealloc>
      return 0;
    80000a1a:	4501                	li	a0,0
}
    80000a1c:	70e2                	ld	ra,56(sp)
    80000a1e:	7442                	ld	s0,48(sp)
    80000a20:	74a2                	ld	s1,40(sp)
    80000a22:	7902                	ld	s2,32(sp)
    80000a24:	69e2                	ld	s3,24(sp)
    80000a26:	6a42                	ld	s4,16(sp)
    80000a28:	6aa2                	ld	s5,8(sp)
    80000a2a:	6121                	addi	sp,sp,64
    80000a2c:	8082                	ret
      kfree(mem);
    80000a2e:	8526                	mv	a0,s1
    80000a30:	fffff097          	auipc	ra,0xfffff
    80000a34:	5ec080e7          	jalr	1516(ra) # 8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80000a38:	864e                	mv	a2,s3
    80000a3a:	85ca                	mv	a1,s2
    80000a3c:	8556                	mv	a0,s5
    80000a3e:	00000097          	auipc	ra,0x0
    80000a42:	f22080e7          	jalr	-222(ra) # 80000960 <uvmdealloc>
      return 0;
    80000a46:	4501                	li	a0,0
    80000a48:	bfd1                	j	80000a1c <uvmalloc+0x74>
    return oldsz;
    80000a4a:	852e                	mv	a0,a1
}
    80000a4c:	8082                	ret
  return newsz;
    80000a4e:	8532                	mv	a0,a2
    80000a50:	b7f1                	j	80000a1c <uvmalloc+0x74>

0000000080000a52 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    80000a52:	7179                	addi	sp,sp,-48
    80000a54:	f406                	sd	ra,40(sp)
    80000a56:	f022                	sd	s0,32(sp)
    80000a58:	ec26                	sd	s1,24(sp)
    80000a5a:	e84a                	sd	s2,16(sp)
    80000a5c:	e44e                	sd	s3,8(sp)
    80000a5e:	e052                	sd	s4,0(sp)
    80000a60:	1800                	addi	s0,sp,48
    80000a62:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80000a64:	84aa                	mv	s1,a0
    80000a66:	6905                	lui	s2,0x1
    80000a68:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000a6a:	4985                	li	s3,1
    80000a6c:	a821                	j	80000a84 <freewalk+0x32>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    80000a6e:	8129                	srli	a0,a0,0xa
      freewalk((pagetable_t)child);
    80000a70:	0532                	slli	a0,a0,0xc
    80000a72:	00000097          	auipc	ra,0x0
    80000a76:	fe0080e7          	jalr	-32(ra) # 80000a52 <freewalk>
      pagetable[i] = 0;
    80000a7a:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    80000a7e:	04a1                	addi	s1,s1,8
    80000a80:	03248163          	beq	s1,s2,80000aa2 <freewalk+0x50>
    pte_t pte = pagetable[i];
    80000a84:	6088                	ld	a0,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000a86:	00f57793          	andi	a5,a0,15
    80000a8a:	ff3782e3          	beq	a5,s3,80000a6e <freewalk+0x1c>
    } else if(pte & PTE_V){
    80000a8e:	8905                	andi	a0,a0,1
    80000a90:	d57d                	beqz	a0,80000a7e <freewalk+0x2c>
      panic("freewalk: leaf");
    80000a92:	00007517          	auipc	a0,0x7
    80000a96:	66650513          	addi	a0,a0,1638 # 800080f8 <etext+0xf8>
    80000a9a:	00005097          	auipc	ra,0x5
    80000a9e:	692080e7          	jalr	1682(ra) # 8000612c <panic>
    }
  }
  kfree((void*)pagetable);
    80000aa2:	8552                	mv	a0,s4
    80000aa4:	fffff097          	auipc	ra,0xfffff
    80000aa8:	578080e7          	jalr	1400(ra) # 8000001c <kfree>
}
    80000aac:	70a2                	ld	ra,40(sp)
    80000aae:	7402                	ld	s0,32(sp)
    80000ab0:	64e2                	ld	s1,24(sp)
    80000ab2:	6942                	ld	s2,16(sp)
    80000ab4:	69a2                	ld	s3,8(sp)
    80000ab6:	6a02                	ld	s4,0(sp)
    80000ab8:	6145                	addi	sp,sp,48
    80000aba:	8082                	ret

0000000080000abc <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80000abc:	1101                	addi	sp,sp,-32
    80000abe:	ec06                	sd	ra,24(sp)
    80000ac0:	e822                	sd	s0,16(sp)
    80000ac2:	e426                	sd	s1,8(sp)
    80000ac4:	1000                	addi	s0,sp,32
    80000ac6:	84aa                	mv	s1,a0
  if(sz > 0)
    80000ac8:	e999                	bnez	a1,80000ade <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80000aca:	8526                	mv	a0,s1
    80000acc:	00000097          	auipc	ra,0x0
    80000ad0:	f86080e7          	jalr	-122(ra) # 80000a52 <freewalk>
}
    80000ad4:	60e2                	ld	ra,24(sp)
    80000ad6:	6442                	ld	s0,16(sp)
    80000ad8:	64a2                	ld	s1,8(sp)
    80000ada:	6105                	addi	sp,sp,32
    80000adc:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80000ade:	6605                	lui	a2,0x1
    80000ae0:	167d                	addi	a2,a2,-1
    80000ae2:	962e                	add	a2,a2,a1
    80000ae4:	4685                	li	a3,1
    80000ae6:	8231                	srli	a2,a2,0xc
    80000ae8:	4581                	li	a1,0
    80000aea:	00000097          	auipc	ra,0x0
    80000aee:	d12080e7          	jalr	-750(ra) # 800007fc <uvmunmap>
    80000af2:	bfe1                	j	80000aca <uvmfree+0xe>

0000000080000af4 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80000af4:	c679                	beqz	a2,80000bc2 <uvmcopy+0xce>
{
    80000af6:	715d                	addi	sp,sp,-80
    80000af8:	e486                	sd	ra,72(sp)
    80000afa:	e0a2                	sd	s0,64(sp)
    80000afc:	fc26                	sd	s1,56(sp)
    80000afe:	f84a                	sd	s2,48(sp)
    80000b00:	f44e                	sd	s3,40(sp)
    80000b02:	f052                	sd	s4,32(sp)
    80000b04:	ec56                	sd	s5,24(sp)
    80000b06:	e85a                	sd	s6,16(sp)
    80000b08:	e45e                	sd	s7,8(sp)
    80000b0a:	0880                	addi	s0,sp,80
    80000b0c:	8b2a                	mv	s6,a0
    80000b0e:	8aae                	mv	s5,a1
    80000b10:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    80000b12:	4981                	li	s3,0
    if((pte = walk(old, i, 0)) == 0)
    80000b14:	4601                	li	a2,0
    80000b16:	85ce                	mv	a1,s3
    80000b18:	855a                	mv	a0,s6
    80000b1a:	00000097          	auipc	ra,0x0
    80000b1e:	a34080e7          	jalr	-1484(ra) # 8000054e <walk>
    80000b22:	c531                	beqz	a0,80000b6e <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80000b24:	6118                	ld	a4,0(a0)
    80000b26:	00177793          	andi	a5,a4,1
    80000b2a:	cbb1                	beqz	a5,80000b7e <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    80000b2c:	00a75593          	srli	a1,a4,0xa
    80000b30:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    80000b34:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    80000b38:	fffff097          	auipc	ra,0xfffff
    80000b3c:	634080e7          	jalr	1588(ra) # 8000016c <kalloc>
    80000b40:	892a                	mv	s2,a0
    80000b42:	c939                	beqz	a0,80000b98 <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    80000b44:	6605                	lui	a2,0x1
    80000b46:	85de                	mv	a1,s7
    80000b48:	fffff097          	auipc	ra,0xfffff
    80000b4c:	76e080e7          	jalr	1902(ra) # 800002b6 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80000b50:	8726                	mv	a4,s1
    80000b52:	86ca                	mv	a3,s2
    80000b54:	6605                	lui	a2,0x1
    80000b56:	85ce                	mv	a1,s3
    80000b58:	8556                	mv	a0,s5
    80000b5a:	00000097          	auipc	ra,0x0
    80000b5e:	adc080e7          	jalr	-1316(ra) # 80000636 <mappages>
    80000b62:	e515                	bnez	a0,80000b8e <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    80000b64:	6785                	lui	a5,0x1
    80000b66:	99be                	add	s3,s3,a5
    80000b68:	fb49e6e3          	bltu	s3,s4,80000b14 <uvmcopy+0x20>
    80000b6c:	a081                	j	80000bac <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    80000b6e:	00007517          	auipc	a0,0x7
    80000b72:	59a50513          	addi	a0,a0,1434 # 80008108 <etext+0x108>
    80000b76:	00005097          	auipc	ra,0x5
    80000b7a:	5b6080e7          	jalr	1462(ra) # 8000612c <panic>
      panic("uvmcopy: page not present");
    80000b7e:	00007517          	auipc	a0,0x7
    80000b82:	5aa50513          	addi	a0,a0,1450 # 80008128 <etext+0x128>
    80000b86:	00005097          	auipc	ra,0x5
    80000b8a:	5a6080e7          	jalr	1446(ra) # 8000612c <panic>
      kfree(mem);
    80000b8e:	854a                	mv	a0,s2
    80000b90:	fffff097          	auipc	ra,0xfffff
    80000b94:	48c080e7          	jalr	1164(ra) # 8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80000b98:	4685                	li	a3,1
    80000b9a:	00c9d613          	srli	a2,s3,0xc
    80000b9e:	4581                	li	a1,0
    80000ba0:	8556                	mv	a0,s5
    80000ba2:	00000097          	auipc	ra,0x0
    80000ba6:	c5a080e7          	jalr	-934(ra) # 800007fc <uvmunmap>
  return -1;
    80000baa:	557d                	li	a0,-1
}
    80000bac:	60a6                	ld	ra,72(sp)
    80000bae:	6406                	ld	s0,64(sp)
    80000bb0:	74e2                	ld	s1,56(sp)
    80000bb2:	7942                	ld	s2,48(sp)
    80000bb4:	79a2                	ld	s3,40(sp)
    80000bb6:	7a02                	ld	s4,32(sp)
    80000bb8:	6ae2                	ld	s5,24(sp)
    80000bba:	6b42                	ld	s6,16(sp)
    80000bbc:	6ba2                	ld	s7,8(sp)
    80000bbe:	6161                	addi	sp,sp,80
    80000bc0:	8082                	ret
  return 0;
    80000bc2:	4501                	li	a0,0
}
    80000bc4:	8082                	ret

0000000080000bc6 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000bc6:	1141                	addi	sp,sp,-16
    80000bc8:	e406                	sd	ra,8(sp)
    80000bca:	e022                	sd	s0,0(sp)
    80000bcc:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80000bce:	4601                	li	a2,0
    80000bd0:	00000097          	auipc	ra,0x0
    80000bd4:	97e080e7          	jalr	-1666(ra) # 8000054e <walk>
  if(pte == 0)
    80000bd8:	c901                	beqz	a0,80000be8 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000bda:	611c                	ld	a5,0(a0)
    80000bdc:	9bbd                	andi	a5,a5,-17
    80000bde:	e11c                	sd	a5,0(a0)
}
    80000be0:	60a2                	ld	ra,8(sp)
    80000be2:	6402                	ld	s0,0(sp)
    80000be4:	0141                	addi	sp,sp,16
    80000be6:	8082                	ret
    panic("uvmclear");
    80000be8:	00007517          	auipc	a0,0x7
    80000bec:	56050513          	addi	a0,a0,1376 # 80008148 <etext+0x148>
    80000bf0:	00005097          	auipc	ra,0x5
    80000bf4:	53c080e7          	jalr	1340(ra) # 8000612c <panic>

0000000080000bf8 <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000bf8:	c6bd                	beqz	a3,80000c66 <copyout+0x6e>
{
    80000bfa:	715d                	addi	sp,sp,-80
    80000bfc:	e486                	sd	ra,72(sp)
    80000bfe:	e0a2                	sd	s0,64(sp)
    80000c00:	fc26                	sd	s1,56(sp)
    80000c02:	f84a                	sd	s2,48(sp)
    80000c04:	f44e                	sd	s3,40(sp)
    80000c06:	f052                	sd	s4,32(sp)
    80000c08:	ec56                	sd	s5,24(sp)
    80000c0a:	e85a                	sd	s6,16(sp)
    80000c0c:	e45e                	sd	s7,8(sp)
    80000c0e:	e062                	sd	s8,0(sp)
    80000c10:	0880                	addi	s0,sp,80
    80000c12:	8b2a                	mv	s6,a0
    80000c14:	8c2e                	mv	s8,a1
    80000c16:	8a32                	mv	s4,a2
    80000c18:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80000c1a:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    80000c1c:	6a85                	lui	s5,0x1
    80000c1e:	a015                	j	80000c42 <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000c20:	9562                	add	a0,a0,s8
    80000c22:	0004861b          	sext.w	a2,s1
    80000c26:	85d2                	mv	a1,s4
    80000c28:	41250533          	sub	a0,a0,s2
    80000c2c:	fffff097          	auipc	ra,0xfffff
    80000c30:	68a080e7          	jalr	1674(ra) # 800002b6 <memmove>

    len -= n;
    80000c34:	409989b3          	sub	s3,s3,s1
    src += n;
    80000c38:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    80000c3a:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000c3e:	02098263          	beqz	s3,80000c62 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    80000c42:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000c46:	85ca                	mv	a1,s2
    80000c48:	855a                	mv	a0,s6
    80000c4a:	00000097          	auipc	ra,0x0
    80000c4e:	9aa080e7          	jalr	-1622(ra) # 800005f4 <walkaddr>
    if(pa0 == 0)
    80000c52:	cd01                	beqz	a0,80000c6a <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    80000c54:	418904b3          	sub	s1,s2,s8
    80000c58:	94d6                	add	s1,s1,s5
    if(n > len)
    80000c5a:	fc99f3e3          	bgeu	s3,s1,80000c20 <copyout+0x28>
    80000c5e:	84ce                	mv	s1,s3
    80000c60:	b7c1                	j	80000c20 <copyout+0x28>
  }
  return 0;
    80000c62:	4501                	li	a0,0
    80000c64:	a021                	j	80000c6c <copyout+0x74>
    80000c66:	4501                	li	a0,0
}
    80000c68:	8082                	ret
      return -1;
    80000c6a:	557d                	li	a0,-1
}
    80000c6c:	60a6                	ld	ra,72(sp)
    80000c6e:	6406                	ld	s0,64(sp)
    80000c70:	74e2                	ld	s1,56(sp)
    80000c72:	7942                	ld	s2,48(sp)
    80000c74:	79a2                	ld	s3,40(sp)
    80000c76:	7a02                	ld	s4,32(sp)
    80000c78:	6ae2                	ld	s5,24(sp)
    80000c7a:	6b42                	ld	s6,16(sp)
    80000c7c:	6ba2                	ld	s7,8(sp)
    80000c7e:	6c02                	ld	s8,0(sp)
    80000c80:	6161                	addi	sp,sp,80
    80000c82:	8082                	ret

0000000080000c84 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000c84:	c6bd                	beqz	a3,80000cf2 <copyin+0x6e>
{
    80000c86:	715d                	addi	sp,sp,-80
    80000c88:	e486                	sd	ra,72(sp)
    80000c8a:	e0a2                	sd	s0,64(sp)
    80000c8c:	fc26                	sd	s1,56(sp)
    80000c8e:	f84a                	sd	s2,48(sp)
    80000c90:	f44e                	sd	s3,40(sp)
    80000c92:	f052                	sd	s4,32(sp)
    80000c94:	ec56                	sd	s5,24(sp)
    80000c96:	e85a                	sd	s6,16(sp)
    80000c98:	e45e                	sd	s7,8(sp)
    80000c9a:	e062                	sd	s8,0(sp)
    80000c9c:	0880                	addi	s0,sp,80
    80000c9e:	8b2a                	mv	s6,a0
    80000ca0:	8a2e                	mv	s4,a1
    80000ca2:	8c32                	mv	s8,a2
    80000ca4:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000ca6:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000ca8:	6a85                	lui	s5,0x1
    80000caa:	a015                	j	80000cce <copyin+0x4a>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000cac:	9562                	add	a0,a0,s8
    80000cae:	0004861b          	sext.w	a2,s1
    80000cb2:	412505b3          	sub	a1,a0,s2
    80000cb6:	8552                	mv	a0,s4
    80000cb8:	fffff097          	auipc	ra,0xfffff
    80000cbc:	5fe080e7          	jalr	1534(ra) # 800002b6 <memmove>

    len -= n;
    80000cc0:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000cc4:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000cc6:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000cca:	02098263          	beqz	s3,80000cee <copyin+0x6a>
    va0 = PGROUNDDOWN(srcva);
    80000cce:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000cd2:	85ca                	mv	a1,s2
    80000cd4:	855a                	mv	a0,s6
    80000cd6:	00000097          	auipc	ra,0x0
    80000cda:	91e080e7          	jalr	-1762(ra) # 800005f4 <walkaddr>
    if(pa0 == 0)
    80000cde:	cd01                	beqz	a0,80000cf6 <copyin+0x72>
    n = PGSIZE - (srcva - va0);
    80000ce0:	418904b3          	sub	s1,s2,s8
    80000ce4:	94d6                	add	s1,s1,s5
    if(n > len)
    80000ce6:	fc99f3e3          	bgeu	s3,s1,80000cac <copyin+0x28>
    80000cea:	84ce                	mv	s1,s3
    80000cec:	b7c1                	j	80000cac <copyin+0x28>
  }
  return 0;
    80000cee:	4501                	li	a0,0
    80000cf0:	a021                	j	80000cf8 <copyin+0x74>
    80000cf2:	4501                	li	a0,0
}
    80000cf4:	8082                	ret
      return -1;
    80000cf6:	557d                	li	a0,-1
}
    80000cf8:	60a6                	ld	ra,72(sp)
    80000cfa:	6406                	ld	s0,64(sp)
    80000cfc:	74e2                	ld	s1,56(sp)
    80000cfe:	7942                	ld	s2,48(sp)
    80000d00:	79a2                	ld	s3,40(sp)
    80000d02:	7a02                	ld	s4,32(sp)
    80000d04:	6ae2                	ld	s5,24(sp)
    80000d06:	6b42                	ld	s6,16(sp)
    80000d08:	6ba2                	ld	s7,8(sp)
    80000d0a:	6c02                	ld	s8,0(sp)
    80000d0c:	6161                	addi	sp,sp,80
    80000d0e:	8082                	ret

0000000080000d10 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000d10:	c6c5                	beqz	a3,80000db8 <copyinstr+0xa8>
{
    80000d12:	715d                	addi	sp,sp,-80
    80000d14:	e486                	sd	ra,72(sp)
    80000d16:	e0a2                	sd	s0,64(sp)
    80000d18:	fc26                	sd	s1,56(sp)
    80000d1a:	f84a                	sd	s2,48(sp)
    80000d1c:	f44e                	sd	s3,40(sp)
    80000d1e:	f052                	sd	s4,32(sp)
    80000d20:	ec56                	sd	s5,24(sp)
    80000d22:	e85a                	sd	s6,16(sp)
    80000d24:	e45e                	sd	s7,8(sp)
    80000d26:	0880                	addi	s0,sp,80
    80000d28:	8a2a                	mv	s4,a0
    80000d2a:	8b2e                	mv	s6,a1
    80000d2c:	8bb2                	mv	s7,a2
    80000d2e:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    80000d30:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000d32:	6985                	lui	s3,0x1
    80000d34:	a035                	j	80000d60 <copyinstr+0x50>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000d36:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80000d3a:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000d3c:	0017b793          	seqz	a5,a5
    80000d40:	40f00533          	neg	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000d44:	60a6                	ld	ra,72(sp)
    80000d46:	6406                	ld	s0,64(sp)
    80000d48:	74e2                	ld	s1,56(sp)
    80000d4a:	7942                	ld	s2,48(sp)
    80000d4c:	79a2                	ld	s3,40(sp)
    80000d4e:	7a02                	ld	s4,32(sp)
    80000d50:	6ae2                	ld	s5,24(sp)
    80000d52:	6b42                	ld	s6,16(sp)
    80000d54:	6ba2                	ld	s7,8(sp)
    80000d56:	6161                	addi	sp,sp,80
    80000d58:	8082                	ret
    srcva = va0 + PGSIZE;
    80000d5a:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    80000d5e:	c8a9                	beqz	s1,80000db0 <copyinstr+0xa0>
    va0 = PGROUNDDOWN(srcva);
    80000d60:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80000d64:	85ca                	mv	a1,s2
    80000d66:	8552                	mv	a0,s4
    80000d68:	00000097          	auipc	ra,0x0
    80000d6c:	88c080e7          	jalr	-1908(ra) # 800005f4 <walkaddr>
    if(pa0 == 0)
    80000d70:	c131                	beqz	a0,80000db4 <copyinstr+0xa4>
    n = PGSIZE - (srcva - va0);
    80000d72:	41790833          	sub	a6,s2,s7
    80000d76:	984e                	add	a6,a6,s3
    if(n > max)
    80000d78:	0104f363          	bgeu	s1,a6,80000d7e <copyinstr+0x6e>
    80000d7c:	8826                	mv	a6,s1
    char *p = (char *) (pa0 + (srcva - va0));
    80000d7e:	955e                	add	a0,a0,s7
    80000d80:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80000d84:	fc080be3          	beqz	a6,80000d5a <copyinstr+0x4a>
    80000d88:	985a                	add	a6,a6,s6
    80000d8a:	87da                	mv	a5,s6
      if(*p == '\0'){
    80000d8c:	41650633          	sub	a2,a0,s6
    80000d90:	14fd                	addi	s1,s1,-1
    80000d92:	9b26                	add	s6,s6,s1
    80000d94:	00f60733          	add	a4,a2,a5
    80000d98:	00074703          	lbu	a4,0(a4)
    80000d9c:	df49                	beqz	a4,80000d36 <copyinstr+0x26>
        *dst = *p;
    80000d9e:	00e78023          	sb	a4,0(a5)
      --max;
    80000da2:	40fb04b3          	sub	s1,s6,a5
      dst++;
    80000da6:	0785                	addi	a5,a5,1
    while(n > 0){
    80000da8:	ff0796e3          	bne	a5,a6,80000d94 <copyinstr+0x84>
      dst++;
    80000dac:	8b42                	mv	s6,a6
    80000dae:	b775                	j	80000d5a <copyinstr+0x4a>
    80000db0:	4781                	li	a5,0
    80000db2:	b769                	j	80000d3c <copyinstr+0x2c>
      return -1;
    80000db4:	557d                	li	a0,-1
    80000db6:	b779                	j	80000d44 <copyinstr+0x34>
  int got_null = 0;
    80000db8:	4781                	li	a5,0
  if(got_null){
    80000dba:	0017b793          	seqz	a5,a5
    80000dbe:	40f00533          	neg	a0,a5
}
    80000dc2:	8082                	ret

0000000080000dc4 <proc_mapstacks>:

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl) {
    80000dc4:	7139                	addi	sp,sp,-64
    80000dc6:	fc06                	sd	ra,56(sp)
    80000dc8:	f822                	sd	s0,48(sp)
    80000dca:	f426                	sd	s1,40(sp)
    80000dcc:	f04a                	sd	s2,32(sp)
    80000dce:	ec4e                	sd	s3,24(sp)
    80000dd0:	e852                	sd	s4,16(sp)
    80000dd2:	e456                	sd	s5,8(sp)
    80000dd4:	e05a                	sd	s6,0(sp)
    80000dd6:	0080                	addi	s0,sp,64
    80000dd8:	89aa                	mv	s3,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80000dda:	00008497          	auipc	s1,0x8
    80000dde:	7d648493          	addi	s1,s1,2006 # 800095b0 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000de2:	8b26                	mv	s6,s1
    80000de4:	00007a97          	auipc	s5,0x7
    80000de8:	21ca8a93          	addi	s5,s5,540 # 80008000 <etext>
    80000dec:	04000937          	lui	s2,0x4000
    80000df0:	197d                	addi	s2,s2,-1
    80000df2:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000df4:	0000ea17          	auipc	s4,0xe
    80000df8:	3bca0a13          	addi	s4,s4,956 # 8000f1b0 <tickslock>
    char *pa = kalloc();
    80000dfc:	fffff097          	auipc	ra,0xfffff
    80000e00:	370080e7          	jalr	880(ra) # 8000016c <kalloc>
    80000e04:	862a                	mv	a2,a0
    if(pa == 0)
    80000e06:	c131                	beqz	a0,80000e4a <proc_mapstacks+0x86>
    uint64 va = KSTACK((int) (p - proc));
    80000e08:	416485b3          	sub	a1,s1,s6
    80000e0c:	8591                	srai	a1,a1,0x4
    80000e0e:	000ab783          	ld	a5,0(s5)
    80000e12:	02f585b3          	mul	a1,a1,a5
    80000e16:	2585                	addiw	a1,a1,1
    80000e18:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000e1c:	4719                	li	a4,6
    80000e1e:	6685                	lui	a3,0x1
    80000e20:	40b905b3          	sub	a1,s2,a1
    80000e24:	854e                	mv	a0,s3
    80000e26:	00000097          	auipc	ra,0x0
    80000e2a:	8b0080e7          	jalr	-1872(ra) # 800006d6 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e2e:	17048493          	addi	s1,s1,368
    80000e32:	fd4495e3          	bne	s1,s4,80000dfc <proc_mapstacks+0x38>
  }
}
    80000e36:	70e2                	ld	ra,56(sp)
    80000e38:	7442                	ld	s0,48(sp)
    80000e3a:	74a2                	ld	s1,40(sp)
    80000e3c:	7902                	ld	s2,32(sp)
    80000e3e:	69e2                	ld	s3,24(sp)
    80000e40:	6a42                	ld	s4,16(sp)
    80000e42:	6aa2                	ld	s5,8(sp)
    80000e44:	6b02                	ld	s6,0(sp)
    80000e46:	6121                	addi	sp,sp,64
    80000e48:	8082                	ret
      panic("kalloc");
    80000e4a:	00007517          	auipc	a0,0x7
    80000e4e:	30e50513          	addi	a0,a0,782 # 80008158 <etext+0x158>
    80000e52:	00005097          	auipc	ra,0x5
    80000e56:	2da080e7          	jalr	730(ra) # 8000612c <panic>

0000000080000e5a <procinit>:

// initialize the proc table at boot time.
void
procinit(void)
{
    80000e5a:	7139                	addi	sp,sp,-64
    80000e5c:	fc06                	sd	ra,56(sp)
    80000e5e:	f822                	sd	s0,48(sp)
    80000e60:	f426                	sd	s1,40(sp)
    80000e62:	f04a                	sd	s2,32(sp)
    80000e64:	ec4e                	sd	s3,24(sp)
    80000e66:	e852                	sd	s4,16(sp)
    80000e68:	e456                	sd	s5,8(sp)
    80000e6a:	e05a                	sd	s6,0(sp)
    80000e6c:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80000e6e:	00007597          	auipc	a1,0x7
    80000e72:	2f258593          	addi	a1,a1,754 # 80008160 <etext+0x160>
    80000e76:	00008517          	auipc	a0,0x8
    80000e7a:	2fa50513          	addi	a0,a0,762 # 80009170 <pid_lock>
    80000e7e:	00006097          	auipc	ra,0x6
    80000e82:	95e080e7          	jalr	-1698(ra) # 800067dc <initlock>
  initlock(&wait_lock, "wait_lock");
    80000e86:	00007597          	auipc	a1,0x7
    80000e8a:	2e258593          	addi	a1,a1,738 # 80008168 <etext+0x168>
    80000e8e:	00008517          	auipc	a0,0x8
    80000e92:	30250513          	addi	a0,a0,770 # 80009190 <wait_lock>
    80000e96:	00006097          	auipc	ra,0x6
    80000e9a:	946080e7          	jalr	-1722(ra) # 800067dc <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e9e:	00008497          	auipc	s1,0x8
    80000ea2:	71248493          	addi	s1,s1,1810 # 800095b0 <proc>
      initlock(&p->lock, "proc");
    80000ea6:	00007b17          	auipc	s6,0x7
    80000eaa:	2d2b0b13          	addi	s6,s6,722 # 80008178 <etext+0x178>
      p->kstack = KSTACK((int) (p - proc));
    80000eae:	8aa6                	mv	s5,s1
    80000eb0:	00007a17          	auipc	s4,0x7
    80000eb4:	150a0a13          	addi	s4,s4,336 # 80008000 <etext>
    80000eb8:	04000937          	lui	s2,0x4000
    80000ebc:	197d                	addi	s2,s2,-1
    80000ebe:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000ec0:	0000e997          	auipc	s3,0xe
    80000ec4:	2f098993          	addi	s3,s3,752 # 8000f1b0 <tickslock>
      initlock(&p->lock, "proc");
    80000ec8:	85da                	mv	a1,s6
    80000eca:	8526                	mv	a0,s1
    80000ecc:	00006097          	auipc	ra,0x6
    80000ed0:	910080e7          	jalr	-1776(ra) # 800067dc <initlock>
      p->kstack = KSTACK((int) (p - proc));
    80000ed4:	415487b3          	sub	a5,s1,s5
    80000ed8:	8791                	srai	a5,a5,0x4
    80000eda:	000a3703          	ld	a4,0(s4)
    80000ede:	02e787b3          	mul	a5,a5,a4
    80000ee2:	2785                	addiw	a5,a5,1
    80000ee4:	00d7979b          	slliw	a5,a5,0xd
    80000ee8:	40f907b3          	sub	a5,s2,a5
    80000eec:	e4bc                	sd	a5,72(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000eee:	17048493          	addi	s1,s1,368
    80000ef2:	fd349be3          	bne	s1,s3,80000ec8 <procinit+0x6e>
  }
}
    80000ef6:	70e2                	ld	ra,56(sp)
    80000ef8:	7442                	ld	s0,48(sp)
    80000efa:	74a2                	ld	s1,40(sp)
    80000efc:	7902                	ld	s2,32(sp)
    80000efe:	69e2                	ld	s3,24(sp)
    80000f00:	6a42                	ld	s4,16(sp)
    80000f02:	6aa2                	ld	s5,8(sp)
    80000f04:	6b02                	ld	s6,0(sp)
    80000f06:	6121                	addi	sp,sp,64
    80000f08:	8082                	ret

0000000080000f0a <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80000f0a:	1141                	addi	sp,sp,-16
    80000f0c:	e422                	sd	s0,8(sp)
    80000f0e:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000f10:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000f12:	2501                	sext.w	a0,a0
    80000f14:	6422                	ld	s0,8(sp)
    80000f16:	0141                	addi	sp,sp,16
    80000f18:	8082                	ret

0000000080000f1a <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void) {
    80000f1a:	1141                	addi	sp,sp,-16
    80000f1c:	e422                	sd	s0,8(sp)
    80000f1e:	0800                	addi	s0,sp,16
    80000f20:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000f22:	2781                	sext.w	a5,a5
    80000f24:	079e                	slli	a5,a5,0x7
  return c;
}
    80000f26:	00008517          	auipc	a0,0x8
    80000f2a:	28a50513          	addi	a0,a0,650 # 800091b0 <cpus>
    80000f2e:	953e                	add	a0,a0,a5
    80000f30:	6422                	ld	s0,8(sp)
    80000f32:	0141                	addi	sp,sp,16
    80000f34:	8082                	ret

0000000080000f36 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void) {
    80000f36:	1101                	addi	sp,sp,-32
    80000f38:	ec06                	sd	ra,24(sp)
    80000f3a:	e822                	sd	s0,16(sp)
    80000f3c:	e426                	sd	s1,8(sp)
    80000f3e:	1000                	addi	s0,sp,32
  push_off();
    80000f40:	00005097          	auipc	ra,0x5
    80000f44:	6d4080e7          	jalr	1748(ra) # 80006614 <push_off>
    80000f48:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000f4a:	2781                	sext.w	a5,a5
    80000f4c:	079e                	slli	a5,a5,0x7
    80000f4e:	00008717          	auipc	a4,0x8
    80000f52:	22270713          	addi	a4,a4,546 # 80009170 <pid_lock>
    80000f56:	97ba                	add	a5,a5,a4
    80000f58:	63a4                	ld	s1,64(a5)
  pop_off();
    80000f5a:	00005097          	auipc	ra,0x5
    80000f5e:	776080e7          	jalr	1910(ra) # 800066d0 <pop_off>
  return p;
}
    80000f62:	8526                	mv	a0,s1
    80000f64:	60e2                	ld	ra,24(sp)
    80000f66:	6442                	ld	s0,16(sp)
    80000f68:	64a2                	ld	s1,8(sp)
    80000f6a:	6105                	addi	sp,sp,32
    80000f6c:	8082                	ret

0000000080000f6e <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80000f6e:	1141                	addi	sp,sp,-16
    80000f70:	e406                	sd	ra,8(sp)
    80000f72:	e022                	sd	s0,0(sp)
    80000f74:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80000f76:	00000097          	auipc	ra,0x0
    80000f7a:	fc0080e7          	jalr	-64(ra) # 80000f36 <myproc>
    80000f7e:	00005097          	auipc	ra,0x5
    80000f82:	7b2080e7          	jalr	1970(ra) # 80006730 <release>

  if (first) {
    80000f86:	00008797          	auipc	a5,0x8
    80000f8a:	93a7a783          	lw	a5,-1734(a5) # 800088c0 <first.1691>
    80000f8e:	eb89                	bnez	a5,80000fa0 <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80000f90:	00001097          	auipc	ra,0x1
    80000f94:	c0a080e7          	jalr	-1014(ra) # 80001b9a <usertrapret>
}
    80000f98:	60a2                	ld	ra,8(sp)
    80000f9a:	6402                	ld	s0,0(sp)
    80000f9c:	0141                	addi	sp,sp,16
    80000f9e:	8082                	ret
    first = 0;
    80000fa0:	00008797          	auipc	a5,0x8
    80000fa4:	9207a023          	sw	zero,-1760(a5) # 800088c0 <first.1691>
    fsinit(ROOTDEV);
    80000fa8:	4505                	li	a0,1
    80000faa:	00002097          	auipc	ra,0x2
    80000fae:	b1a080e7          	jalr	-1254(ra) # 80002ac4 <fsinit>
    80000fb2:	bff9                	j	80000f90 <forkret+0x22>

0000000080000fb4 <allocpid>:
allocpid() {
    80000fb4:	1101                	addi	sp,sp,-32
    80000fb6:	ec06                	sd	ra,24(sp)
    80000fb8:	e822                	sd	s0,16(sp)
    80000fba:	e426                	sd	s1,8(sp)
    80000fbc:	e04a                	sd	s2,0(sp)
    80000fbe:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80000fc0:	00008917          	auipc	s2,0x8
    80000fc4:	1b090913          	addi	s2,s2,432 # 80009170 <pid_lock>
    80000fc8:	854a                	mv	a0,s2
    80000fca:	00005097          	auipc	ra,0x5
    80000fce:	696080e7          	jalr	1686(ra) # 80006660 <acquire>
  pid = nextpid;
    80000fd2:	00008797          	auipc	a5,0x8
    80000fd6:	8f278793          	addi	a5,a5,-1806 # 800088c4 <nextpid>
    80000fda:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80000fdc:	0014871b          	addiw	a4,s1,1
    80000fe0:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80000fe2:	854a                	mv	a0,s2
    80000fe4:	00005097          	auipc	ra,0x5
    80000fe8:	74c080e7          	jalr	1868(ra) # 80006730 <release>
}
    80000fec:	8526                	mv	a0,s1
    80000fee:	60e2                	ld	ra,24(sp)
    80000ff0:	6442                	ld	s0,16(sp)
    80000ff2:	64a2                	ld	s1,8(sp)
    80000ff4:	6902                	ld	s2,0(sp)
    80000ff6:	6105                	addi	sp,sp,32
    80000ff8:	8082                	ret

0000000080000ffa <proc_pagetable>:
{
    80000ffa:	1101                	addi	sp,sp,-32
    80000ffc:	ec06                	sd	ra,24(sp)
    80000ffe:	e822                	sd	s0,16(sp)
    80001000:	e426                	sd	s1,8(sp)
    80001002:	e04a                	sd	s2,0(sp)
    80001004:	1000                	addi	s0,sp,32
    80001006:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80001008:	00000097          	auipc	ra,0x0
    8000100c:	8b8080e7          	jalr	-1864(ra) # 800008c0 <uvmcreate>
    80001010:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80001012:	c121                	beqz	a0,80001052 <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80001014:	4729                	li	a4,10
    80001016:	00006697          	auipc	a3,0x6
    8000101a:	fea68693          	addi	a3,a3,-22 # 80007000 <_trampoline>
    8000101e:	6605                	lui	a2,0x1
    80001020:	040005b7          	lui	a1,0x4000
    80001024:	15fd                	addi	a1,a1,-1
    80001026:	05b2                	slli	a1,a1,0xc
    80001028:	fffff097          	auipc	ra,0xfffff
    8000102c:	60e080e7          	jalr	1550(ra) # 80000636 <mappages>
    80001030:	02054863          	bltz	a0,80001060 <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80001034:	4719                	li	a4,6
    80001036:	06093683          	ld	a3,96(s2)
    8000103a:	6605                	lui	a2,0x1
    8000103c:	020005b7          	lui	a1,0x2000
    80001040:	15fd                	addi	a1,a1,-1
    80001042:	05b6                	slli	a1,a1,0xd
    80001044:	8526                	mv	a0,s1
    80001046:	fffff097          	auipc	ra,0xfffff
    8000104a:	5f0080e7          	jalr	1520(ra) # 80000636 <mappages>
    8000104e:	02054163          	bltz	a0,80001070 <proc_pagetable+0x76>
}
    80001052:	8526                	mv	a0,s1
    80001054:	60e2                	ld	ra,24(sp)
    80001056:	6442                	ld	s0,16(sp)
    80001058:	64a2                	ld	s1,8(sp)
    8000105a:	6902                	ld	s2,0(sp)
    8000105c:	6105                	addi	sp,sp,32
    8000105e:	8082                	ret
    uvmfree(pagetable, 0);
    80001060:	4581                	li	a1,0
    80001062:	8526                	mv	a0,s1
    80001064:	00000097          	auipc	ra,0x0
    80001068:	a58080e7          	jalr	-1448(ra) # 80000abc <uvmfree>
    return 0;
    8000106c:	4481                	li	s1,0
    8000106e:	b7d5                	j	80001052 <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001070:	4681                	li	a3,0
    80001072:	4605                	li	a2,1
    80001074:	040005b7          	lui	a1,0x4000
    80001078:	15fd                	addi	a1,a1,-1
    8000107a:	05b2                	slli	a1,a1,0xc
    8000107c:	8526                	mv	a0,s1
    8000107e:	fffff097          	auipc	ra,0xfffff
    80001082:	77e080e7          	jalr	1918(ra) # 800007fc <uvmunmap>
    uvmfree(pagetable, 0);
    80001086:	4581                	li	a1,0
    80001088:	8526                	mv	a0,s1
    8000108a:	00000097          	auipc	ra,0x0
    8000108e:	a32080e7          	jalr	-1486(ra) # 80000abc <uvmfree>
    return 0;
    80001092:	4481                	li	s1,0
    80001094:	bf7d                	j	80001052 <proc_pagetable+0x58>

0000000080001096 <proc_freepagetable>:
{
    80001096:	1101                	addi	sp,sp,-32
    80001098:	ec06                	sd	ra,24(sp)
    8000109a:	e822                	sd	s0,16(sp)
    8000109c:	e426                	sd	s1,8(sp)
    8000109e:	e04a                	sd	s2,0(sp)
    800010a0:	1000                	addi	s0,sp,32
    800010a2:	84aa                	mv	s1,a0
    800010a4:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    800010a6:	4681                	li	a3,0
    800010a8:	4605                	li	a2,1
    800010aa:	040005b7          	lui	a1,0x4000
    800010ae:	15fd                	addi	a1,a1,-1
    800010b0:	05b2                	slli	a1,a1,0xc
    800010b2:	fffff097          	auipc	ra,0xfffff
    800010b6:	74a080e7          	jalr	1866(ra) # 800007fc <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    800010ba:	4681                	li	a3,0
    800010bc:	4605                	li	a2,1
    800010be:	020005b7          	lui	a1,0x2000
    800010c2:	15fd                	addi	a1,a1,-1
    800010c4:	05b6                	slli	a1,a1,0xd
    800010c6:	8526                	mv	a0,s1
    800010c8:	fffff097          	auipc	ra,0xfffff
    800010cc:	734080e7          	jalr	1844(ra) # 800007fc <uvmunmap>
  uvmfree(pagetable, sz);
    800010d0:	85ca                	mv	a1,s2
    800010d2:	8526                	mv	a0,s1
    800010d4:	00000097          	auipc	ra,0x0
    800010d8:	9e8080e7          	jalr	-1560(ra) # 80000abc <uvmfree>
}
    800010dc:	60e2                	ld	ra,24(sp)
    800010de:	6442                	ld	s0,16(sp)
    800010e0:	64a2                	ld	s1,8(sp)
    800010e2:	6902                	ld	s2,0(sp)
    800010e4:	6105                	addi	sp,sp,32
    800010e6:	8082                	ret

00000000800010e8 <freeproc>:
{
    800010e8:	1101                	addi	sp,sp,-32
    800010ea:	ec06                	sd	ra,24(sp)
    800010ec:	e822                	sd	s0,16(sp)
    800010ee:	e426                	sd	s1,8(sp)
    800010f0:	1000                	addi	s0,sp,32
    800010f2:	84aa                	mv	s1,a0
  if(p->trapframe)
    800010f4:	7128                	ld	a0,96(a0)
    800010f6:	c509                	beqz	a0,80001100 <freeproc+0x18>
    kfree((void*)p->trapframe);
    800010f8:	fffff097          	auipc	ra,0xfffff
    800010fc:	f24080e7          	jalr	-220(ra) # 8000001c <kfree>
  p->trapframe = 0;
    80001100:	0604b023          	sd	zero,96(s1)
  if(p->pagetable)
    80001104:	6ca8                	ld	a0,88(s1)
    80001106:	c511                	beqz	a0,80001112 <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    80001108:	68ac                	ld	a1,80(s1)
    8000110a:	00000097          	auipc	ra,0x0
    8000110e:	f8c080e7          	jalr	-116(ra) # 80001096 <proc_freepagetable>
  p->pagetable = 0;
    80001112:	0404bc23          	sd	zero,88(s1)
  p->sz = 0;
    80001116:	0404b823          	sd	zero,80(s1)
  p->pid = 0;
    8000111a:	0204ac23          	sw	zero,56(s1)
  p->parent = 0;
    8000111e:	0404b023          	sd	zero,64(s1)
  p->name[0] = 0;
    80001122:	16048023          	sb	zero,352(s1)
  p->chan = 0;
    80001126:	0204b423          	sd	zero,40(s1)
  p->killed = 0;
    8000112a:	0204a823          	sw	zero,48(s1)
  p->xstate = 0;
    8000112e:	0204aa23          	sw	zero,52(s1)
  p->state = UNUSED;
    80001132:	0204a023          	sw	zero,32(s1)
}
    80001136:	60e2                	ld	ra,24(sp)
    80001138:	6442                	ld	s0,16(sp)
    8000113a:	64a2                	ld	s1,8(sp)
    8000113c:	6105                	addi	sp,sp,32
    8000113e:	8082                	ret

0000000080001140 <allocproc>:
{
    80001140:	1101                	addi	sp,sp,-32
    80001142:	ec06                	sd	ra,24(sp)
    80001144:	e822                	sd	s0,16(sp)
    80001146:	e426                	sd	s1,8(sp)
    80001148:	e04a                	sd	s2,0(sp)
    8000114a:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    8000114c:	00008497          	auipc	s1,0x8
    80001150:	46448493          	addi	s1,s1,1124 # 800095b0 <proc>
    80001154:	0000e917          	auipc	s2,0xe
    80001158:	05c90913          	addi	s2,s2,92 # 8000f1b0 <tickslock>
    acquire(&p->lock);
    8000115c:	8526                	mv	a0,s1
    8000115e:	00005097          	auipc	ra,0x5
    80001162:	502080e7          	jalr	1282(ra) # 80006660 <acquire>
    if(p->state == UNUSED) {
    80001166:	509c                	lw	a5,32(s1)
    80001168:	cf81                	beqz	a5,80001180 <allocproc+0x40>
      release(&p->lock);
    8000116a:	8526                	mv	a0,s1
    8000116c:	00005097          	auipc	ra,0x5
    80001170:	5c4080e7          	jalr	1476(ra) # 80006730 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001174:	17048493          	addi	s1,s1,368
    80001178:	ff2492e3          	bne	s1,s2,8000115c <allocproc+0x1c>
  return 0;
    8000117c:	4481                	li	s1,0
    8000117e:	a889                	j	800011d0 <allocproc+0x90>
  p->pid = allocpid();
    80001180:	00000097          	auipc	ra,0x0
    80001184:	e34080e7          	jalr	-460(ra) # 80000fb4 <allocpid>
    80001188:	dc88                	sw	a0,56(s1)
  p->state = USED;
    8000118a:	4785                	li	a5,1
    8000118c:	d09c                	sw	a5,32(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    8000118e:	fffff097          	auipc	ra,0xfffff
    80001192:	fde080e7          	jalr	-34(ra) # 8000016c <kalloc>
    80001196:	892a                	mv	s2,a0
    80001198:	f0a8                	sd	a0,96(s1)
    8000119a:	c131                	beqz	a0,800011de <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    8000119c:	8526                	mv	a0,s1
    8000119e:	00000097          	auipc	ra,0x0
    800011a2:	e5c080e7          	jalr	-420(ra) # 80000ffa <proc_pagetable>
    800011a6:	892a                	mv	s2,a0
    800011a8:	eca8                	sd	a0,88(s1)
  if(p->pagetable == 0){
    800011aa:	c531                	beqz	a0,800011f6 <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    800011ac:	07000613          	li	a2,112
    800011b0:	4581                	li	a1,0
    800011b2:	06848513          	addi	a0,s1,104
    800011b6:	fffff097          	auipc	ra,0xfffff
    800011ba:	0a0080e7          	jalr	160(ra) # 80000256 <memset>
  p->context.ra = (uint64)forkret;
    800011be:	00000797          	auipc	a5,0x0
    800011c2:	db078793          	addi	a5,a5,-592 # 80000f6e <forkret>
    800011c6:	f4bc                	sd	a5,104(s1)
  p->context.sp = p->kstack + PGSIZE;
    800011c8:	64bc                	ld	a5,72(s1)
    800011ca:	6705                	lui	a4,0x1
    800011cc:	97ba                	add	a5,a5,a4
    800011ce:	f8bc                	sd	a5,112(s1)
}
    800011d0:	8526                	mv	a0,s1
    800011d2:	60e2                	ld	ra,24(sp)
    800011d4:	6442                	ld	s0,16(sp)
    800011d6:	64a2                	ld	s1,8(sp)
    800011d8:	6902                	ld	s2,0(sp)
    800011da:	6105                	addi	sp,sp,32
    800011dc:	8082                	ret
    freeproc(p);
    800011de:	8526                	mv	a0,s1
    800011e0:	00000097          	auipc	ra,0x0
    800011e4:	f08080e7          	jalr	-248(ra) # 800010e8 <freeproc>
    release(&p->lock);
    800011e8:	8526                	mv	a0,s1
    800011ea:	00005097          	auipc	ra,0x5
    800011ee:	546080e7          	jalr	1350(ra) # 80006730 <release>
    return 0;
    800011f2:	84ca                	mv	s1,s2
    800011f4:	bff1                	j	800011d0 <allocproc+0x90>
    freeproc(p);
    800011f6:	8526                	mv	a0,s1
    800011f8:	00000097          	auipc	ra,0x0
    800011fc:	ef0080e7          	jalr	-272(ra) # 800010e8 <freeproc>
    release(&p->lock);
    80001200:	8526                	mv	a0,s1
    80001202:	00005097          	auipc	ra,0x5
    80001206:	52e080e7          	jalr	1326(ra) # 80006730 <release>
    return 0;
    8000120a:	84ca                	mv	s1,s2
    8000120c:	b7d1                	j	800011d0 <allocproc+0x90>

000000008000120e <userinit>:
{
    8000120e:	1101                	addi	sp,sp,-32
    80001210:	ec06                	sd	ra,24(sp)
    80001212:	e822                	sd	s0,16(sp)
    80001214:	e426                	sd	s1,8(sp)
    80001216:	1000                	addi	s0,sp,32
  p = allocproc();
    80001218:	00000097          	auipc	ra,0x0
    8000121c:	f28080e7          	jalr	-216(ra) # 80001140 <allocproc>
    80001220:	84aa                	mv	s1,a0
  initproc = p;
    80001222:	00008797          	auipc	a5,0x8
    80001226:	dea7b723          	sd	a0,-530(a5) # 80009010 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    8000122a:	03400613          	li	a2,52
    8000122e:	00007597          	auipc	a1,0x7
    80001232:	6a258593          	addi	a1,a1,1698 # 800088d0 <initcode>
    80001236:	6d28                	ld	a0,88(a0)
    80001238:	fffff097          	auipc	ra,0xfffff
    8000123c:	6b6080e7          	jalr	1718(ra) # 800008ee <uvminit>
  p->sz = PGSIZE;
    80001240:	6785                	lui	a5,0x1
    80001242:	e8bc                	sd	a5,80(s1)
  p->trapframe->epc = 0;      // user program counter
    80001244:	70b8                	ld	a4,96(s1)
    80001246:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    8000124a:	70b8                	ld	a4,96(s1)
    8000124c:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    8000124e:	4641                	li	a2,16
    80001250:	00007597          	auipc	a1,0x7
    80001254:	f3058593          	addi	a1,a1,-208 # 80008180 <etext+0x180>
    80001258:	16048513          	addi	a0,s1,352
    8000125c:	fffff097          	auipc	ra,0xfffff
    80001260:	14c080e7          	jalr	332(ra) # 800003a8 <safestrcpy>
  p->cwd = namei("/");
    80001264:	00007517          	auipc	a0,0x7
    80001268:	f2c50513          	addi	a0,a0,-212 # 80008190 <etext+0x190>
    8000126c:	00002097          	auipc	ra,0x2
    80001270:	286080e7          	jalr	646(ra) # 800034f2 <namei>
    80001274:	14a4bc23          	sd	a0,344(s1)
  p->state = RUNNABLE;
    80001278:	478d                	li	a5,3
    8000127a:	d09c                	sw	a5,32(s1)
  release(&p->lock);
    8000127c:	8526                	mv	a0,s1
    8000127e:	00005097          	auipc	ra,0x5
    80001282:	4b2080e7          	jalr	1202(ra) # 80006730 <release>
}
    80001286:	60e2                	ld	ra,24(sp)
    80001288:	6442                	ld	s0,16(sp)
    8000128a:	64a2                	ld	s1,8(sp)
    8000128c:	6105                	addi	sp,sp,32
    8000128e:	8082                	ret

0000000080001290 <growproc>:
{
    80001290:	1101                	addi	sp,sp,-32
    80001292:	ec06                	sd	ra,24(sp)
    80001294:	e822                	sd	s0,16(sp)
    80001296:	e426                	sd	s1,8(sp)
    80001298:	e04a                	sd	s2,0(sp)
    8000129a:	1000                	addi	s0,sp,32
    8000129c:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    8000129e:	00000097          	auipc	ra,0x0
    800012a2:	c98080e7          	jalr	-872(ra) # 80000f36 <myproc>
    800012a6:	892a                	mv	s2,a0
  sz = p->sz;
    800012a8:	692c                	ld	a1,80(a0)
    800012aa:	0005861b          	sext.w	a2,a1
  if(n > 0){
    800012ae:	00904f63          	bgtz	s1,800012cc <growproc+0x3c>
  } else if(n < 0){
    800012b2:	0204cc63          	bltz	s1,800012ea <growproc+0x5a>
  p->sz = sz;
    800012b6:	1602                	slli	a2,a2,0x20
    800012b8:	9201                	srli	a2,a2,0x20
    800012ba:	04c93823          	sd	a2,80(s2)
  return 0;
    800012be:	4501                	li	a0,0
}
    800012c0:	60e2                	ld	ra,24(sp)
    800012c2:	6442                	ld	s0,16(sp)
    800012c4:	64a2                	ld	s1,8(sp)
    800012c6:	6902                	ld	s2,0(sp)
    800012c8:	6105                	addi	sp,sp,32
    800012ca:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    800012cc:	9e25                	addw	a2,a2,s1
    800012ce:	1602                	slli	a2,a2,0x20
    800012d0:	9201                	srli	a2,a2,0x20
    800012d2:	1582                	slli	a1,a1,0x20
    800012d4:	9181                	srli	a1,a1,0x20
    800012d6:	6d28                	ld	a0,88(a0)
    800012d8:	fffff097          	auipc	ra,0xfffff
    800012dc:	6d0080e7          	jalr	1744(ra) # 800009a8 <uvmalloc>
    800012e0:	0005061b          	sext.w	a2,a0
    800012e4:	fa69                	bnez	a2,800012b6 <growproc+0x26>
      return -1;
    800012e6:	557d                	li	a0,-1
    800012e8:	bfe1                	j	800012c0 <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    800012ea:	9e25                	addw	a2,a2,s1
    800012ec:	1602                	slli	a2,a2,0x20
    800012ee:	9201                	srli	a2,a2,0x20
    800012f0:	1582                	slli	a1,a1,0x20
    800012f2:	9181                	srli	a1,a1,0x20
    800012f4:	6d28                	ld	a0,88(a0)
    800012f6:	fffff097          	auipc	ra,0xfffff
    800012fa:	66a080e7          	jalr	1642(ra) # 80000960 <uvmdealloc>
    800012fe:	0005061b          	sext.w	a2,a0
    80001302:	bf55                	j	800012b6 <growproc+0x26>

0000000080001304 <fork>:
{
    80001304:	7179                	addi	sp,sp,-48
    80001306:	f406                	sd	ra,40(sp)
    80001308:	f022                	sd	s0,32(sp)
    8000130a:	ec26                	sd	s1,24(sp)
    8000130c:	e84a                	sd	s2,16(sp)
    8000130e:	e44e                	sd	s3,8(sp)
    80001310:	e052                	sd	s4,0(sp)
    80001312:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001314:	00000097          	auipc	ra,0x0
    80001318:	c22080e7          	jalr	-990(ra) # 80000f36 <myproc>
    8000131c:	892a                	mv	s2,a0
  if((np = allocproc()) == 0){
    8000131e:	00000097          	auipc	ra,0x0
    80001322:	e22080e7          	jalr	-478(ra) # 80001140 <allocproc>
    80001326:	10050b63          	beqz	a0,8000143c <fork+0x138>
    8000132a:	89aa                	mv	s3,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    8000132c:	05093603          	ld	a2,80(s2)
    80001330:	6d2c                	ld	a1,88(a0)
    80001332:	05893503          	ld	a0,88(s2)
    80001336:	fffff097          	auipc	ra,0xfffff
    8000133a:	7be080e7          	jalr	1982(ra) # 80000af4 <uvmcopy>
    8000133e:	04054663          	bltz	a0,8000138a <fork+0x86>
  np->sz = p->sz;
    80001342:	05093783          	ld	a5,80(s2)
    80001346:	04f9b823          	sd	a5,80(s3)
  *(np->trapframe) = *(p->trapframe);
    8000134a:	06093683          	ld	a3,96(s2)
    8000134e:	87b6                	mv	a5,a3
    80001350:	0609b703          	ld	a4,96(s3)
    80001354:	12068693          	addi	a3,a3,288
    80001358:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    8000135c:	6788                	ld	a0,8(a5)
    8000135e:	6b8c                	ld	a1,16(a5)
    80001360:	6f90                	ld	a2,24(a5)
    80001362:	01073023          	sd	a6,0(a4)
    80001366:	e708                	sd	a0,8(a4)
    80001368:	eb0c                	sd	a1,16(a4)
    8000136a:	ef10                	sd	a2,24(a4)
    8000136c:	02078793          	addi	a5,a5,32
    80001370:	02070713          	addi	a4,a4,32
    80001374:	fed792e3          	bne	a5,a3,80001358 <fork+0x54>
  np->trapframe->a0 = 0;
    80001378:	0609b783          	ld	a5,96(s3)
    8000137c:	0607b823          	sd	zero,112(a5)
    80001380:	0d800493          	li	s1,216
  for(i = 0; i < NOFILE; i++)
    80001384:	15800a13          	li	s4,344
    80001388:	a03d                	j	800013b6 <fork+0xb2>
    freeproc(np);
    8000138a:	854e                	mv	a0,s3
    8000138c:	00000097          	auipc	ra,0x0
    80001390:	d5c080e7          	jalr	-676(ra) # 800010e8 <freeproc>
    release(&np->lock);
    80001394:	854e                	mv	a0,s3
    80001396:	00005097          	auipc	ra,0x5
    8000139a:	39a080e7          	jalr	922(ra) # 80006730 <release>
    return -1;
    8000139e:	5a7d                	li	s4,-1
    800013a0:	a069                	j	8000142a <fork+0x126>
      np->ofile[i] = filedup(p->ofile[i]);
    800013a2:	00002097          	auipc	ra,0x2
    800013a6:	7e6080e7          	jalr	2022(ra) # 80003b88 <filedup>
    800013aa:	009987b3          	add	a5,s3,s1
    800013ae:	e388                	sd	a0,0(a5)
  for(i = 0; i < NOFILE; i++)
    800013b0:	04a1                	addi	s1,s1,8
    800013b2:	01448763          	beq	s1,s4,800013c0 <fork+0xbc>
    if(p->ofile[i])
    800013b6:	009907b3          	add	a5,s2,s1
    800013ba:	6388                	ld	a0,0(a5)
    800013bc:	f17d                	bnez	a0,800013a2 <fork+0x9e>
    800013be:	bfcd                	j	800013b0 <fork+0xac>
  np->cwd = idup(p->cwd);
    800013c0:	15893503          	ld	a0,344(s2)
    800013c4:	00002097          	auipc	ra,0x2
    800013c8:	93a080e7          	jalr	-1734(ra) # 80002cfe <idup>
    800013cc:	14a9bc23          	sd	a0,344(s3)
  safestrcpy(np->name, p->name, sizeof(p->name));
    800013d0:	4641                	li	a2,16
    800013d2:	16090593          	addi	a1,s2,352
    800013d6:	16098513          	addi	a0,s3,352
    800013da:	fffff097          	auipc	ra,0xfffff
    800013de:	fce080e7          	jalr	-50(ra) # 800003a8 <safestrcpy>
  pid = np->pid;
    800013e2:	0389aa03          	lw	s4,56(s3)
  release(&np->lock);
    800013e6:	854e                	mv	a0,s3
    800013e8:	00005097          	auipc	ra,0x5
    800013ec:	348080e7          	jalr	840(ra) # 80006730 <release>
  acquire(&wait_lock);
    800013f0:	00008497          	auipc	s1,0x8
    800013f4:	da048493          	addi	s1,s1,-608 # 80009190 <wait_lock>
    800013f8:	8526                	mv	a0,s1
    800013fa:	00005097          	auipc	ra,0x5
    800013fe:	266080e7          	jalr	614(ra) # 80006660 <acquire>
  np->parent = p;
    80001402:	0529b023          	sd	s2,64(s3)
  release(&wait_lock);
    80001406:	8526                	mv	a0,s1
    80001408:	00005097          	auipc	ra,0x5
    8000140c:	328080e7          	jalr	808(ra) # 80006730 <release>
  acquire(&np->lock);
    80001410:	854e                	mv	a0,s3
    80001412:	00005097          	auipc	ra,0x5
    80001416:	24e080e7          	jalr	590(ra) # 80006660 <acquire>
  np->state = RUNNABLE;
    8000141a:	478d                	li	a5,3
    8000141c:	02f9a023          	sw	a5,32(s3)
  release(&np->lock);
    80001420:	854e                	mv	a0,s3
    80001422:	00005097          	auipc	ra,0x5
    80001426:	30e080e7          	jalr	782(ra) # 80006730 <release>
}
    8000142a:	8552                	mv	a0,s4
    8000142c:	70a2                	ld	ra,40(sp)
    8000142e:	7402                	ld	s0,32(sp)
    80001430:	64e2                	ld	s1,24(sp)
    80001432:	6942                	ld	s2,16(sp)
    80001434:	69a2                	ld	s3,8(sp)
    80001436:	6a02                	ld	s4,0(sp)
    80001438:	6145                	addi	sp,sp,48
    8000143a:	8082                	ret
    return -1;
    8000143c:	5a7d                	li	s4,-1
    8000143e:	b7f5                	j	8000142a <fork+0x126>

0000000080001440 <scheduler>:
{
    80001440:	7139                	addi	sp,sp,-64
    80001442:	fc06                	sd	ra,56(sp)
    80001444:	f822                	sd	s0,48(sp)
    80001446:	f426                	sd	s1,40(sp)
    80001448:	f04a                	sd	s2,32(sp)
    8000144a:	ec4e                	sd	s3,24(sp)
    8000144c:	e852                	sd	s4,16(sp)
    8000144e:	e456                	sd	s5,8(sp)
    80001450:	e05a                	sd	s6,0(sp)
    80001452:	0080                	addi	s0,sp,64
    80001454:	8792                	mv	a5,tp
  int id = r_tp();
    80001456:	2781                	sext.w	a5,a5
  c->proc = 0;
    80001458:	00779a93          	slli	s5,a5,0x7
    8000145c:	00008717          	auipc	a4,0x8
    80001460:	d1470713          	addi	a4,a4,-748 # 80009170 <pid_lock>
    80001464:	9756                	add	a4,a4,s5
    80001466:	04073023          	sd	zero,64(a4)
        swtch(&c->context, &p->context);
    8000146a:	00008717          	auipc	a4,0x8
    8000146e:	d4e70713          	addi	a4,a4,-690 # 800091b8 <cpus+0x8>
    80001472:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    80001474:	498d                	li	s3,3
        p->state = RUNNING;
    80001476:	4b11                	li	s6,4
        c->proc = p;
    80001478:	079e                	slli	a5,a5,0x7
    8000147a:	00008a17          	auipc	s4,0x8
    8000147e:	cf6a0a13          	addi	s4,s4,-778 # 80009170 <pid_lock>
    80001482:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    80001484:	0000e917          	auipc	s2,0xe
    80001488:	d2c90913          	addi	s2,s2,-724 # 8000f1b0 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000148c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001490:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001494:	10079073          	csrw	sstatus,a5
    80001498:	00008497          	auipc	s1,0x8
    8000149c:	11848493          	addi	s1,s1,280 # 800095b0 <proc>
    800014a0:	a03d                	j	800014ce <scheduler+0x8e>
        p->state = RUNNING;
    800014a2:	0364a023          	sw	s6,32(s1)
        c->proc = p;
    800014a6:	049a3023          	sd	s1,64(s4)
        swtch(&c->context, &p->context);
    800014aa:	06848593          	addi	a1,s1,104
    800014ae:	8556                	mv	a0,s5
    800014b0:	00000097          	auipc	ra,0x0
    800014b4:	640080e7          	jalr	1600(ra) # 80001af0 <swtch>
        c->proc = 0;
    800014b8:	040a3023          	sd	zero,64(s4)
      release(&p->lock);
    800014bc:	8526                	mv	a0,s1
    800014be:	00005097          	auipc	ra,0x5
    800014c2:	272080e7          	jalr	626(ra) # 80006730 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    800014c6:	17048493          	addi	s1,s1,368
    800014ca:	fd2481e3          	beq	s1,s2,8000148c <scheduler+0x4c>
      acquire(&p->lock);
    800014ce:	8526                	mv	a0,s1
    800014d0:	00005097          	auipc	ra,0x5
    800014d4:	190080e7          	jalr	400(ra) # 80006660 <acquire>
      if(p->state == RUNNABLE) {
    800014d8:	509c                	lw	a5,32(s1)
    800014da:	ff3791e3          	bne	a5,s3,800014bc <scheduler+0x7c>
    800014de:	b7d1                	j	800014a2 <scheduler+0x62>

00000000800014e0 <sched>:
{
    800014e0:	7179                	addi	sp,sp,-48
    800014e2:	f406                	sd	ra,40(sp)
    800014e4:	f022                	sd	s0,32(sp)
    800014e6:	ec26                	sd	s1,24(sp)
    800014e8:	e84a                	sd	s2,16(sp)
    800014ea:	e44e                	sd	s3,8(sp)
    800014ec:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    800014ee:	00000097          	auipc	ra,0x0
    800014f2:	a48080e7          	jalr	-1464(ra) # 80000f36 <myproc>
    800014f6:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    800014f8:	00005097          	auipc	ra,0x5
    800014fc:	0ee080e7          	jalr	238(ra) # 800065e6 <holding>
    80001500:	c93d                	beqz	a0,80001576 <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001502:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    80001504:	2781                	sext.w	a5,a5
    80001506:	079e                	slli	a5,a5,0x7
    80001508:	00008717          	auipc	a4,0x8
    8000150c:	c6870713          	addi	a4,a4,-920 # 80009170 <pid_lock>
    80001510:	97ba                	add	a5,a5,a4
    80001512:	0b87a703          	lw	a4,184(a5)
    80001516:	4785                	li	a5,1
    80001518:	06f71763          	bne	a4,a5,80001586 <sched+0xa6>
  if(p->state == RUNNING)
    8000151c:	5098                	lw	a4,32(s1)
    8000151e:	4791                	li	a5,4
    80001520:	06f70b63          	beq	a4,a5,80001596 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001524:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001528:	8b89                	andi	a5,a5,2
  if(intr_get())
    8000152a:	efb5                	bnez	a5,800015a6 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    8000152c:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    8000152e:	00008917          	auipc	s2,0x8
    80001532:	c4290913          	addi	s2,s2,-958 # 80009170 <pid_lock>
    80001536:	2781                	sext.w	a5,a5
    80001538:	079e                	slli	a5,a5,0x7
    8000153a:	97ca                	add	a5,a5,s2
    8000153c:	0bc7a983          	lw	s3,188(a5)
    80001540:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80001542:	2781                	sext.w	a5,a5
    80001544:	079e                	slli	a5,a5,0x7
    80001546:	00008597          	auipc	a1,0x8
    8000154a:	c7258593          	addi	a1,a1,-910 # 800091b8 <cpus+0x8>
    8000154e:	95be                	add	a1,a1,a5
    80001550:	06848513          	addi	a0,s1,104
    80001554:	00000097          	auipc	ra,0x0
    80001558:	59c080e7          	jalr	1436(ra) # 80001af0 <swtch>
    8000155c:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    8000155e:	2781                	sext.w	a5,a5
    80001560:	079e                	slli	a5,a5,0x7
    80001562:	97ca                	add	a5,a5,s2
    80001564:	0b37ae23          	sw	s3,188(a5)
}
    80001568:	70a2                	ld	ra,40(sp)
    8000156a:	7402                	ld	s0,32(sp)
    8000156c:	64e2                	ld	s1,24(sp)
    8000156e:	6942                	ld	s2,16(sp)
    80001570:	69a2                	ld	s3,8(sp)
    80001572:	6145                	addi	sp,sp,48
    80001574:	8082                	ret
    panic("sched p->lock");
    80001576:	00007517          	auipc	a0,0x7
    8000157a:	c2250513          	addi	a0,a0,-990 # 80008198 <etext+0x198>
    8000157e:	00005097          	auipc	ra,0x5
    80001582:	bae080e7          	jalr	-1106(ra) # 8000612c <panic>
    panic("sched locks");
    80001586:	00007517          	auipc	a0,0x7
    8000158a:	c2250513          	addi	a0,a0,-990 # 800081a8 <etext+0x1a8>
    8000158e:	00005097          	auipc	ra,0x5
    80001592:	b9e080e7          	jalr	-1122(ra) # 8000612c <panic>
    panic("sched running");
    80001596:	00007517          	auipc	a0,0x7
    8000159a:	c2250513          	addi	a0,a0,-990 # 800081b8 <etext+0x1b8>
    8000159e:	00005097          	auipc	ra,0x5
    800015a2:	b8e080e7          	jalr	-1138(ra) # 8000612c <panic>
    panic("sched interruptible");
    800015a6:	00007517          	auipc	a0,0x7
    800015aa:	c2250513          	addi	a0,a0,-990 # 800081c8 <etext+0x1c8>
    800015ae:	00005097          	auipc	ra,0x5
    800015b2:	b7e080e7          	jalr	-1154(ra) # 8000612c <panic>

00000000800015b6 <yield>:
{
    800015b6:	1101                	addi	sp,sp,-32
    800015b8:	ec06                	sd	ra,24(sp)
    800015ba:	e822                	sd	s0,16(sp)
    800015bc:	e426                	sd	s1,8(sp)
    800015be:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    800015c0:	00000097          	auipc	ra,0x0
    800015c4:	976080e7          	jalr	-1674(ra) # 80000f36 <myproc>
    800015c8:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800015ca:	00005097          	auipc	ra,0x5
    800015ce:	096080e7          	jalr	150(ra) # 80006660 <acquire>
  p->state = RUNNABLE;
    800015d2:	478d                	li	a5,3
    800015d4:	d09c                	sw	a5,32(s1)
  sched();
    800015d6:	00000097          	auipc	ra,0x0
    800015da:	f0a080e7          	jalr	-246(ra) # 800014e0 <sched>
  release(&p->lock);
    800015de:	8526                	mv	a0,s1
    800015e0:	00005097          	auipc	ra,0x5
    800015e4:	150080e7          	jalr	336(ra) # 80006730 <release>
}
    800015e8:	60e2                	ld	ra,24(sp)
    800015ea:	6442                	ld	s0,16(sp)
    800015ec:	64a2                	ld	s1,8(sp)
    800015ee:	6105                	addi	sp,sp,32
    800015f0:	8082                	ret

00000000800015f2 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    800015f2:	7179                	addi	sp,sp,-48
    800015f4:	f406                	sd	ra,40(sp)
    800015f6:	f022                	sd	s0,32(sp)
    800015f8:	ec26                	sd	s1,24(sp)
    800015fa:	e84a                	sd	s2,16(sp)
    800015fc:	e44e                	sd	s3,8(sp)
    800015fe:	1800                	addi	s0,sp,48
    80001600:	89aa                	mv	s3,a0
    80001602:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001604:	00000097          	auipc	ra,0x0
    80001608:	932080e7          	jalr	-1742(ra) # 80000f36 <myproc>
    8000160c:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    8000160e:	00005097          	auipc	ra,0x5
    80001612:	052080e7          	jalr	82(ra) # 80006660 <acquire>
  release(lk);
    80001616:	854a                	mv	a0,s2
    80001618:	00005097          	auipc	ra,0x5
    8000161c:	118080e7          	jalr	280(ra) # 80006730 <release>

  // Go to sleep.
  p->chan = chan;
    80001620:	0334b423          	sd	s3,40(s1)
  p->state = SLEEPING;
    80001624:	4789                	li	a5,2
    80001626:	d09c                	sw	a5,32(s1)

  sched();
    80001628:	00000097          	auipc	ra,0x0
    8000162c:	eb8080e7          	jalr	-328(ra) # 800014e0 <sched>

  // Tidy up.
  p->chan = 0;
    80001630:	0204b423          	sd	zero,40(s1)

  // Reacquire original lock.
  release(&p->lock);
    80001634:	8526                	mv	a0,s1
    80001636:	00005097          	auipc	ra,0x5
    8000163a:	0fa080e7          	jalr	250(ra) # 80006730 <release>
  acquire(lk);
    8000163e:	854a                	mv	a0,s2
    80001640:	00005097          	auipc	ra,0x5
    80001644:	020080e7          	jalr	32(ra) # 80006660 <acquire>
}
    80001648:	70a2                	ld	ra,40(sp)
    8000164a:	7402                	ld	s0,32(sp)
    8000164c:	64e2                	ld	s1,24(sp)
    8000164e:	6942                	ld	s2,16(sp)
    80001650:	69a2                	ld	s3,8(sp)
    80001652:	6145                	addi	sp,sp,48
    80001654:	8082                	ret

0000000080001656 <wait>:
{
    80001656:	715d                	addi	sp,sp,-80
    80001658:	e486                	sd	ra,72(sp)
    8000165a:	e0a2                	sd	s0,64(sp)
    8000165c:	fc26                	sd	s1,56(sp)
    8000165e:	f84a                	sd	s2,48(sp)
    80001660:	f44e                	sd	s3,40(sp)
    80001662:	f052                	sd	s4,32(sp)
    80001664:	ec56                	sd	s5,24(sp)
    80001666:	e85a                	sd	s6,16(sp)
    80001668:	e45e                	sd	s7,8(sp)
    8000166a:	e062                	sd	s8,0(sp)
    8000166c:	0880                	addi	s0,sp,80
    8000166e:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    80001670:	00000097          	auipc	ra,0x0
    80001674:	8c6080e7          	jalr	-1850(ra) # 80000f36 <myproc>
    80001678:	892a                	mv	s2,a0
  acquire(&wait_lock);
    8000167a:	00008517          	auipc	a0,0x8
    8000167e:	b1650513          	addi	a0,a0,-1258 # 80009190 <wait_lock>
    80001682:	00005097          	auipc	ra,0x5
    80001686:	fde080e7          	jalr	-34(ra) # 80006660 <acquire>
    havekids = 0;
    8000168a:	4b81                	li	s7,0
        if(np->state == ZOMBIE){
    8000168c:	4a15                	li	s4,5
    for(np = proc; np < &proc[NPROC]; np++){
    8000168e:	0000e997          	auipc	s3,0xe
    80001692:	b2298993          	addi	s3,s3,-1246 # 8000f1b0 <tickslock>
        havekids = 1;
    80001696:	4a85                	li	s5,1
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001698:	00008c17          	auipc	s8,0x8
    8000169c:	af8c0c13          	addi	s8,s8,-1288 # 80009190 <wait_lock>
    havekids = 0;
    800016a0:	875e                	mv	a4,s7
    for(np = proc; np < &proc[NPROC]; np++){
    800016a2:	00008497          	auipc	s1,0x8
    800016a6:	f0e48493          	addi	s1,s1,-242 # 800095b0 <proc>
    800016aa:	a0bd                	j	80001718 <wait+0xc2>
          pid = np->pid;
    800016ac:	0384a983          	lw	s3,56(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    800016b0:	000b0e63          	beqz	s6,800016cc <wait+0x76>
    800016b4:	4691                	li	a3,4
    800016b6:	03448613          	addi	a2,s1,52
    800016ba:	85da                	mv	a1,s6
    800016bc:	05893503          	ld	a0,88(s2)
    800016c0:	fffff097          	auipc	ra,0xfffff
    800016c4:	538080e7          	jalr	1336(ra) # 80000bf8 <copyout>
    800016c8:	02054563          	bltz	a0,800016f2 <wait+0x9c>
          freeproc(np);
    800016cc:	8526                	mv	a0,s1
    800016ce:	00000097          	auipc	ra,0x0
    800016d2:	a1a080e7          	jalr	-1510(ra) # 800010e8 <freeproc>
          release(&np->lock);
    800016d6:	8526                	mv	a0,s1
    800016d8:	00005097          	auipc	ra,0x5
    800016dc:	058080e7          	jalr	88(ra) # 80006730 <release>
          release(&wait_lock);
    800016e0:	00008517          	auipc	a0,0x8
    800016e4:	ab050513          	addi	a0,a0,-1360 # 80009190 <wait_lock>
    800016e8:	00005097          	auipc	ra,0x5
    800016ec:	048080e7          	jalr	72(ra) # 80006730 <release>
          return pid;
    800016f0:	a09d                	j	80001756 <wait+0x100>
            release(&np->lock);
    800016f2:	8526                	mv	a0,s1
    800016f4:	00005097          	auipc	ra,0x5
    800016f8:	03c080e7          	jalr	60(ra) # 80006730 <release>
            release(&wait_lock);
    800016fc:	00008517          	auipc	a0,0x8
    80001700:	a9450513          	addi	a0,a0,-1388 # 80009190 <wait_lock>
    80001704:	00005097          	auipc	ra,0x5
    80001708:	02c080e7          	jalr	44(ra) # 80006730 <release>
            return -1;
    8000170c:	59fd                	li	s3,-1
    8000170e:	a0a1                	j	80001756 <wait+0x100>
    for(np = proc; np < &proc[NPROC]; np++){
    80001710:	17048493          	addi	s1,s1,368
    80001714:	03348463          	beq	s1,s3,8000173c <wait+0xe6>
      if(np->parent == p){
    80001718:	60bc                	ld	a5,64(s1)
    8000171a:	ff279be3          	bne	a5,s2,80001710 <wait+0xba>
        acquire(&np->lock);
    8000171e:	8526                	mv	a0,s1
    80001720:	00005097          	auipc	ra,0x5
    80001724:	f40080e7          	jalr	-192(ra) # 80006660 <acquire>
        if(np->state == ZOMBIE){
    80001728:	509c                	lw	a5,32(s1)
    8000172a:	f94781e3          	beq	a5,s4,800016ac <wait+0x56>
        release(&np->lock);
    8000172e:	8526                	mv	a0,s1
    80001730:	00005097          	auipc	ra,0x5
    80001734:	000080e7          	jalr	ra # 80006730 <release>
        havekids = 1;
    80001738:	8756                	mv	a4,s5
    8000173a:	bfd9                	j	80001710 <wait+0xba>
    if(!havekids || p->killed){
    8000173c:	c701                	beqz	a4,80001744 <wait+0xee>
    8000173e:	03092783          	lw	a5,48(s2)
    80001742:	c79d                	beqz	a5,80001770 <wait+0x11a>
      release(&wait_lock);
    80001744:	00008517          	auipc	a0,0x8
    80001748:	a4c50513          	addi	a0,a0,-1460 # 80009190 <wait_lock>
    8000174c:	00005097          	auipc	ra,0x5
    80001750:	fe4080e7          	jalr	-28(ra) # 80006730 <release>
      return -1;
    80001754:	59fd                	li	s3,-1
}
    80001756:	854e                	mv	a0,s3
    80001758:	60a6                	ld	ra,72(sp)
    8000175a:	6406                	ld	s0,64(sp)
    8000175c:	74e2                	ld	s1,56(sp)
    8000175e:	7942                	ld	s2,48(sp)
    80001760:	79a2                	ld	s3,40(sp)
    80001762:	7a02                	ld	s4,32(sp)
    80001764:	6ae2                	ld	s5,24(sp)
    80001766:	6b42                	ld	s6,16(sp)
    80001768:	6ba2                	ld	s7,8(sp)
    8000176a:	6c02                	ld	s8,0(sp)
    8000176c:	6161                	addi	sp,sp,80
    8000176e:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001770:	85e2                	mv	a1,s8
    80001772:	854a                	mv	a0,s2
    80001774:	00000097          	auipc	ra,0x0
    80001778:	e7e080e7          	jalr	-386(ra) # 800015f2 <sleep>
    havekids = 0;
    8000177c:	b715                	j	800016a0 <wait+0x4a>

000000008000177e <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    8000177e:	7139                	addi	sp,sp,-64
    80001780:	fc06                	sd	ra,56(sp)
    80001782:	f822                	sd	s0,48(sp)
    80001784:	f426                	sd	s1,40(sp)
    80001786:	f04a                	sd	s2,32(sp)
    80001788:	ec4e                	sd	s3,24(sp)
    8000178a:	e852                	sd	s4,16(sp)
    8000178c:	e456                	sd	s5,8(sp)
    8000178e:	0080                	addi	s0,sp,64
    80001790:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80001792:	00008497          	auipc	s1,0x8
    80001796:	e1e48493          	addi	s1,s1,-482 # 800095b0 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    8000179a:	4989                	li	s3,2
        p->state = RUNNABLE;
    8000179c:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    8000179e:	0000e917          	auipc	s2,0xe
    800017a2:	a1290913          	addi	s2,s2,-1518 # 8000f1b0 <tickslock>
    800017a6:	a821                	j	800017be <wakeup+0x40>
        p->state = RUNNABLE;
    800017a8:	0354a023          	sw	s5,32(s1)
      }
      release(&p->lock);
    800017ac:	8526                	mv	a0,s1
    800017ae:	00005097          	auipc	ra,0x5
    800017b2:	f82080e7          	jalr	-126(ra) # 80006730 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800017b6:	17048493          	addi	s1,s1,368
    800017ba:	03248463          	beq	s1,s2,800017e2 <wakeup+0x64>
    if(p != myproc()){
    800017be:	fffff097          	auipc	ra,0xfffff
    800017c2:	778080e7          	jalr	1912(ra) # 80000f36 <myproc>
    800017c6:	fea488e3          	beq	s1,a0,800017b6 <wakeup+0x38>
      acquire(&p->lock);
    800017ca:	8526                	mv	a0,s1
    800017cc:	00005097          	auipc	ra,0x5
    800017d0:	e94080e7          	jalr	-364(ra) # 80006660 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    800017d4:	509c                	lw	a5,32(s1)
    800017d6:	fd379be3          	bne	a5,s3,800017ac <wakeup+0x2e>
    800017da:	749c                	ld	a5,40(s1)
    800017dc:	fd4798e3          	bne	a5,s4,800017ac <wakeup+0x2e>
    800017e0:	b7e1                	j	800017a8 <wakeup+0x2a>
    }
  }
}
    800017e2:	70e2                	ld	ra,56(sp)
    800017e4:	7442                	ld	s0,48(sp)
    800017e6:	74a2                	ld	s1,40(sp)
    800017e8:	7902                	ld	s2,32(sp)
    800017ea:	69e2                	ld	s3,24(sp)
    800017ec:	6a42                	ld	s4,16(sp)
    800017ee:	6aa2                	ld	s5,8(sp)
    800017f0:	6121                	addi	sp,sp,64
    800017f2:	8082                	ret

00000000800017f4 <reparent>:
{
    800017f4:	7179                	addi	sp,sp,-48
    800017f6:	f406                	sd	ra,40(sp)
    800017f8:	f022                	sd	s0,32(sp)
    800017fa:	ec26                	sd	s1,24(sp)
    800017fc:	e84a                	sd	s2,16(sp)
    800017fe:	e44e                	sd	s3,8(sp)
    80001800:	e052                	sd	s4,0(sp)
    80001802:	1800                	addi	s0,sp,48
    80001804:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001806:	00008497          	auipc	s1,0x8
    8000180a:	daa48493          	addi	s1,s1,-598 # 800095b0 <proc>
      pp->parent = initproc;
    8000180e:	00008a17          	auipc	s4,0x8
    80001812:	802a0a13          	addi	s4,s4,-2046 # 80009010 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001816:	0000e997          	auipc	s3,0xe
    8000181a:	99a98993          	addi	s3,s3,-1638 # 8000f1b0 <tickslock>
    8000181e:	a029                	j	80001828 <reparent+0x34>
    80001820:	17048493          	addi	s1,s1,368
    80001824:	01348d63          	beq	s1,s3,8000183e <reparent+0x4a>
    if(pp->parent == p){
    80001828:	60bc                	ld	a5,64(s1)
    8000182a:	ff279be3          	bne	a5,s2,80001820 <reparent+0x2c>
      pp->parent = initproc;
    8000182e:	000a3503          	ld	a0,0(s4)
    80001832:	e0a8                	sd	a0,64(s1)
      wakeup(initproc);
    80001834:	00000097          	auipc	ra,0x0
    80001838:	f4a080e7          	jalr	-182(ra) # 8000177e <wakeup>
    8000183c:	b7d5                	j	80001820 <reparent+0x2c>
}
    8000183e:	70a2                	ld	ra,40(sp)
    80001840:	7402                	ld	s0,32(sp)
    80001842:	64e2                	ld	s1,24(sp)
    80001844:	6942                	ld	s2,16(sp)
    80001846:	69a2                	ld	s3,8(sp)
    80001848:	6a02                	ld	s4,0(sp)
    8000184a:	6145                	addi	sp,sp,48
    8000184c:	8082                	ret

000000008000184e <exit>:
{
    8000184e:	7179                	addi	sp,sp,-48
    80001850:	f406                	sd	ra,40(sp)
    80001852:	f022                	sd	s0,32(sp)
    80001854:	ec26                	sd	s1,24(sp)
    80001856:	e84a                	sd	s2,16(sp)
    80001858:	e44e                	sd	s3,8(sp)
    8000185a:	e052                	sd	s4,0(sp)
    8000185c:	1800                	addi	s0,sp,48
    8000185e:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    80001860:	fffff097          	auipc	ra,0xfffff
    80001864:	6d6080e7          	jalr	1750(ra) # 80000f36 <myproc>
    80001868:	89aa                	mv	s3,a0
  if(p == initproc)
    8000186a:	00007797          	auipc	a5,0x7
    8000186e:	7a67b783          	ld	a5,1958(a5) # 80009010 <initproc>
    80001872:	0d850493          	addi	s1,a0,216
    80001876:	15850913          	addi	s2,a0,344
    8000187a:	02a79363          	bne	a5,a0,800018a0 <exit+0x52>
    panic("init exiting");
    8000187e:	00007517          	auipc	a0,0x7
    80001882:	96250513          	addi	a0,a0,-1694 # 800081e0 <etext+0x1e0>
    80001886:	00005097          	auipc	ra,0x5
    8000188a:	8a6080e7          	jalr	-1882(ra) # 8000612c <panic>
      fileclose(f);
    8000188e:	00002097          	auipc	ra,0x2
    80001892:	34c080e7          	jalr	844(ra) # 80003bda <fileclose>
      p->ofile[fd] = 0;
    80001896:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    8000189a:	04a1                	addi	s1,s1,8
    8000189c:	01248563          	beq	s1,s2,800018a6 <exit+0x58>
    if(p->ofile[fd]){
    800018a0:	6088                	ld	a0,0(s1)
    800018a2:	f575                	bnez	a0,8000188e <exit+0x40>
    800018a4:	bfdd                	j	8000189a <exit+0x4c>
  begin_op();
    800018a6:	00002097          	auipc	ra,0x2
    800018aa:	e68080e7          	jalr	-408(ra) # 8000370e <begin_op>
  iput(p->cwd);
    800018ae:	1589b503          	ld	a0,344(s3)
    800018b2:	00001097          	auipc	ra,0x1
    800018b6:	644080e7          	jalr	1604(ra) # 80002ef6 <iput>
  end_op();
    800018ba:	00002097          	auipc	ra,0x2
    800018be:	ed4080e7          	jalr	-300(ra) # 8000378e <end_op>
  p->cwd = 0;
    800018c2:	1409bc23          	sd	zero,344(s3)
  acquire(&wait_lock);
    800018c6:	00008497          	auipc	s1,0x8
    800018ca:	8ca48493          	addi	s1,s1,-1846 # 80009190 <wait_lock>
    800018ce:	8526                	mv	a0,s1
    800018d0:	00005097          	auipc	ra,0x5
    800018d4:	d90080e7          	jalr	-624(ra) # 80006660 <acquire>
  reparent(p);
    800018d8:	854e                	mv	a0,s3
    800018da:	00000097          	auipc	ra,0x0
    800018de:	f1a080e7          	jalr	-230(ra) # 800017f4 <reparent>
  wakeup(p->parent);
    800018e2:	0409b503          	ld	a0,64(s3)
    800018e6:	00000097          	auipc	ra,0x0
    800018ea:	e98080e7          	jalr	-360(ra) # 8000177e <wakeup>
  acquire(&p->lock);
    800018ee:	854e                	mv	a0,s3
    800018f0:	00005097          	auipc	ra,0x5
    800018f4:	d70080e7          	jalr	-656(ra) # 80006660 <acquire>
  p->xstate = status;
    800018f8:	0349aa23          	sw	s4,52(s3)
  p->state = ZOMBIE;
    800018fc:	4795                	li	a5,5
    800018fe:	02f9a023          	sw	a5,32(s3)
  release(&wait_lock);
    80001902:	8526                	mv	a0,s1
    80001904:	00005097          	auipc	ra,0x5
    80001908:	e2c080e7          	jalr	-468(ra) # 80006730 <release>
  sched();
    8000190c:	00000097          	auipc	ra,0x0
    80001910:	bd4080e7          	jalr	-1068(ra) # 800014e0 <sched>
  panic("zombie exit");
    80001914:	00007517          	auipc	a0,0x7
    80001918:	8dc50513          	addi	a0,a0,-1828 # 800081f0 <etext+0x1f0>
    8000191c:	00005097          	auipc	ra,0x5
    80001920:	810080e7          	jalr	-2032(ra) # 8000612c <panic>

0000000080001924 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80001924:	7179                	addi	sp,sp,-48
    80001926:	f406                	sd	ra,40(sp)
    80001928:	f022                	sd	s0,32(sp)
    8000192a:	ec26                	sd	s1,24(sp)
    8000192c:	e84a                	sd	s2,16(sp)
    8000192e:	e44e                	sd	s3,8(sp)
    80001930:	1800                	addi	s0,sp,48
    80001932:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80001934:	00008497          	auipc	s1,0x8
    80001938:	c7c48493          	addi	s1,s1,-900 # 800095b0 <proc>
    8000193c:	0000e997          	auipc	s3,0xe
    80001940:	87498993          	addi	s3,s3,-1932 # 8000f1b0 <tickslock>
    acquire(&p->lock);
    80001944:	8526                	mv	a0,s1
    80001946:	00005097          	auipc	ra,0x5
    8000194a:	d1a080e7          	jalr	-742(ra) # 80006660 <acquire>
    if(p->pid == pid){
    8000194e:	5c9c                	lw	a5,56(s1)
    80001950:	01278d63          	beq	a5,s2,8000196a <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80001954:	8526                	mv	a0,s1
    80001956:	00005097          	auipc	ra,0x5
    8000195a:	dda080e7          	jalr	-550(ra) # 80006730 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    8000195e:	17048493          	addi	s1,s1,368
    80001962:	ff3491e3          	bne	s1,s3,80001944 <kill+0x20>
  }
  return -1;
    80001966:	557d                	li	a0,-1
    80001968:	a829                	j	80001982 <kill+0x5e>
      p->killed = 1;
    8000196a:	4785                	li	a5,1
    8000196c:	d89c                	sw	a5,48(s1)
      if(p->state == SLEEPING){
    8000196e:	5098                	lw	a4,32(s1)
    80001970:	4789                	li	a5,2
    80001972:	00f70f63          	beq	a4,a5,80001990 <kill+0x6c>
      release(&p->lock);
    80001976:	8526                	mv	a0,s1
    80001978:	00005097          	auipc	ra,0x5
    8000197c:	db8080e7          	jalr	-584(ra) # 80006730 <release>
      return 0;
    80001980:	4501                	li	a0,0
}
    80001982:	70a2                	ld	ra,40(sp)
    80001984:	7402                	ld	s0,32(sp)
    80001986:	64e2                	ld	s1,24(sp)
    80001988:	6942                	ld	s2,16(sp)
    8000198a:	69a2                	ld	s3,8(sp)
    8000198c:	6145                	addi	sp,sp,48
    8000198e:	8082                	ret
        p->state = RUNNABLE;
    80001990:	478d                	li	a5,3
    80001992:	d09c                	sw	a5,32(s1)
    80001994:	b7cd                	j	80001976 <kill+0x52>

0000000080001996 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80001996:	7179                	addi	sp,sp,-48
    80001998:	f406                	sd	ra,40(sp)
    8000199a:	f022                	sd	s0,32(sp)
    8000199c:	ec26                	sd	s1,24(sp)
    8000199e:	e84a                	sd	s2,16(sp)
    800019a0:	e44e                	sd	s3,8(sp)
    800019a2:	e052                	sd	s4,0(sp)
    800019a4:	1800                	addi	s0,sp,48
    800019a6:	84aa                	mv	s1,a0
    800019a8:	892e                	mv	s2,a1
    800019aa:	89b2                	mv	s3,a2
    800019ac:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800019ae:	fffff097          	auipc	ra,0xfffff
    800019b2:	588080e7          	jalr	1416(ra) # 80000f36 <myproc>
  if(user_dst){
    800019b6:	c08d                	beqz	s1,800019d8 <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    800019b8:	86d2                	mv	a3,s4
    800019ba:	864e                	mv	a2,s3
    800019bc:	85ca                	mv	a1,s2
    800019be:	6d28                	ld	a0,88(a0)
    800019c0:	fffff097          	auipc	ra,0xfffff
    800019c4:	238080e7          	jalr	568(ra) # 80000bf8 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    800019c8:	70a2                	ld	ra,40(sp)
    800019ca:	7402                	ld	s0,32(sp)
    800019cc:	64e2                	ld	s1,24(sp)
    800019ce:	6942                	ld	s2,16(sp)
    800019d0:	69a2                	ld	s3,8(sp)
    800019d2:	6a02                	ld	s4,0(sp)
    800019d4:	6145                	addi	sp,sp,48
    800019d6:	8082                	ret
    memmove((char *)dst, src, len);
    800019d8:	000a061b          	sext.w	a2,s4
    800019dc:	85ce                	mv	a1,s3
    800019de:	854a                	mv	a0,s2
    800019e0:	fffff097          	auipc	ra,0xfffff
    800019e4:	8d6080e7          	jalr	-1834(ra) # 800002b6 <memmove>
    return 0;
    800019e8:	8526                	mv	a0,s1
    800019ea:	bff9                	j	800019c8 <either_copyout+0x32>

00000000800019ec <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    800019ec:	7179                	addi	sp,sp,-48
    800019ee:	f406                	sd	ra,40(sp)
    800019f0:	f022                	sd	s0,32(sp)
    800019f2:	ec26                	sd	s1,24(sp)
    800019f4:	e84a                	sd	s2,16(sp)
    800019f6:	e44e                	sd	s3,8(sp)
    800019f8:	e052                	sd	s4,0(sp)
    800019fa:	1800                	addi	s0,sp,48
    800019fc:	892a                	mv	s2,a0
    800019fe:	84ae                	mv	s1,a1
    80001a00:	89b2                	mv	s3,a2
    80001a02:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001a04:	fffff097          	auipc	ra,0xfffff
    80001a08:	532080e7          	jalr	1330(ra) # 80000f36 <myproc>
  if(user_src){
    80001a0c:	c08d                	beqz	s1,80001a2e <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80001a0e:	86d2                	mv	a3,s4
    80001a10:	864e                	mv	a2,s3
    80001a12:	85ca                	mv	a1,s2
    80001a14:	6d28                	ld	a0,88(a0)
    80001a16:	fffff097          	auipc	ra,0xfffff
    80001a1a:	26e080e7          	jalr	622(ra) # 80000c84 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001a1e:	70a2                	ld	ra,40(sp)
    80001a20:	7402                	ld	s0,32(sp)
    80001a22:	64e2                	ld	s1,24(sp)
    80001a24:	6942                	ld	s2,16(sp)
    80001a26:	69a2                	ld	s3,8(sp)
    80001a28:	6a02                	ld	s4,0(sp)
    80001a2a:	6145                	addi	sp,sp,48
    80001a2c:	8082                	ret
    memmove(dst, (char*)src, len);
    80001a2e:	000a061b          	sext.w	a2,s4
    80001a32:	85ce                	mv	a1,s3
    80001a34:	854a                	mv	a0,s2
    80001a36:	fffff097          	auipc	ra,0xfffff
    80001a3a:	880080e7          	jalr	-1920(ra) # 800002b6 <memmove>
    return 0;
    80001a3e:	8526                	mv	a0,s1
    80001a40:	bff9                	j	80001a1e <either_copyin+0x32>

0000000080001a42 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001a42:	715d                	addi	sp,sp,-80
    80001a44:	e486                	sd	ra,72(sp)
    80001a46:	e0a2                	sd	s0,64(sp)
    80001a48:	fc26                	sd	s1,56(sp)
    80001a4a:	f84a                	sd	s2,48(sp)
    80001a4c:	f44e                	sd	s3,40(sp)
    80001a4e:	f052                	sd	s4,32(sp)
    80001a50:	ec56                	sd	s5,24(sp)
    80001a52:	e85a                	sd	s6,16(sp)
    80001a54:	e45e                	sd	s7,8(sp)
    80001a56:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80001a58:	00007517          	auipc	a0,0x7
    80001a5c:	e1050513          	addi	a0,a0,-496 # 80008868 <digits+0x88>
    80001a60:	00004097          	auipc	ra,0x4
    80001a64:	716080e7          	jalr	1814(ra) # 80006176 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001a68:	00008497          	auipc	s1,0x8
    80001a6c:	ca848493          	addi	s1,s1,-856 # 80009710 <proc+0x160>
    80001a70:	0000e917          	auipc	s2,0xe
    80001a74:	8a090913          	addi	s2,s2,-1888 # 8000f310 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a78:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001a7a:	00006997          	auipc	s3,0x6
    80001a7e:	78698993          	addi	s3,s3,1926 # 80008200 <etext+0x200>
    printf("%d %s %s", p->pid, state, p->name);
    80001a82:	00006a97          	auipc	s5,0x6
    80001a86:	786a8a93          	addi	s5,s5,1926 # 80008208 <etext+0x208>
    printf("\n");
    80001a8a:	00007a17          	auipc	s4,0x7
    80001a8e:	ddea0a13          	addi	s4,s4,-546 # 80008868 <digits+0x88>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a92:	00006b97          	auipc	s7,0x6
    80001a96:	7aeb8b93          	addi	s7,s7,1966 # 80008240 <states.1728>
    80001a9a:	a00d                	j	80001abc <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80001a9c:	ed86a583          	lw	a1,-296(a3)
    80001aa0:	8556                	mv	a0,s5
    80001aa2:	00004097          	auipc	ra,0x4
    80001aa6:	6d4080e7          	jalr	1748(ra) # 80006176 <printf>
    printf("\n");
    80001aaa:	8552                	mv	a0,s4
    80001aac:	00004097          	auipc	ra,0x4
    80001ab0:	6ca080e7          	jalr	1738(ra) # 80006176 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001ab4:	17048493          	addi	s1,s1,368
    80001ab8:	03248163          	beq	s1,s2,80001ada <procdump+0x98>
    if(p->state == UNUSED)
    80001abc:	86a6                	mv	a3,s1
    80001abe:	ec04a783          	lw	a5,-320(s1)
    80001ac2:	dbed                	beqz	a5,80001ab4 <procdump+0x72>
      state = "???";
    80001ac4:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001ac6:	fcfb6be3          	bltu	s6,a5,80001a9c <procdump+0x5a>
    80001aca:	1782                	slli	a5,a5,0x20
    80001acc:	9381                	srli	a5,a5,0x20
    80001ace:	078e                	slli	a5,a5,0x3
    80001ad0:	97de                	add	a5,a5,s7
    80001ad2:	6390                	ld	a2,0(a5)
    80001ad4:	f661                	bnez	a2,80001a9c <procdump+0x5a>
      state = "???";
    80001ad6:	864e                	mv	a2,s3
    80001ad8:	b7d1                	j	80001a9c <procdump+0x5a>
  }
}
    80001ada:	60a6                	ld	ra,72(sp)
    80001adc:	6406                	ld	s0,64(sp)
    80001ade:	74e2                	ld	s1,56(sp)
    80001ae0:	7942                	ld	s2,48(sp)
    80001ae2:	79a2                	ld	s3,40(sp)
    80001ae4:	7a02                	ld	s4,32(sp)
    80001ae6:	6ae2                	ld	s5,24(sp)
    80001ae8:	6b42                	ld	s6,16(sp)
    80001aea:	6ba2                	ld	s7,8(sp)
    80001aec:	6161                	addi	sp,sp,80
    80001aee:	8082                	ret

0000000080001af0 <swtch>:
    80001af0:	00153023          	sd	ra,0(a0)
    80001af4:	00253423          	sd	sp,8(a0)
    80001af8:	e900                	sd	s0,16(a0)
    80001afa:	ed04                	sd	s1,24(a0)
    80001afc:	03253023          	sd	s2,32(a0)
    80001b00:	03353423          	sd	s3,40(a0)
    80001b04:	03453823          	sd	s4,48(a0)
    80001b08:	03553c23          	sd	s5,56(a0)
    80001b0c:	05653023          	sd	s6,64(a0)
    80001b10:	05753423          	sd	s7,72(a0)
    80001b14:	05853823          	sd	s8,80(a0)
    80001b18:	05953c23          	sd	s9,88(a0)
    80001b1c:	07a53023          	sd	s10,96(a0)
    80001b20:	07b53423          	sd	s11,104(a0)
    80001b24:	0005b083          	ld	ra,0(a1)
    80001b28:	0085b103          	ld	sp,8(a1)
    80001b2c:	6980                	ld	s0,16(a1)
    80001b2e:	6d84                	ld	s1,24(a1)
    80001b30:	0205b903          	ld	s2,32(a1)
    80001b34:	0285b983          	ld	s3,40(a1)
    80001b38:	0305ba03          	ld	s4,48(a1)
    80001b3c:	0385ba83          	ld	s5,56(a1)
    80001b40:	0405bb03          	ld	s6,64(a1)
    80001b44:	0485bb83          	ld	s7,72(a1)
    80001b48:	0505bc03          	ld	s8,80(a1)
    80001b4c:	0585bc83          	ld	s9,88(a1)
    80001b50:	0605bd03          	ld	s10,96(a1)
    80001b54:	0685bd83          	ld	s11,104(a1)
    80001b58:	8082                	ret

0000000080001b5a <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001b5a:	1141                	addi	sp,sp,-16
    80001b5c:	e406                	sd	ra,8(sp)
    80001b5e:	e022                	sd	s0,0(sp)
    80001b60:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001b62:	00006597          	auipc	a1,0x6
    80001b66:	70e58593          	addi	a1,a1,1806 # 80008270 <states.1728+0x30>
    80001b6a:	0000d517          	auipc	a0,0xd
    80001b6e:	64650513          	addi	a0,a0,1606 # 8000f1b0 <tickslock>
    80001b72:	00005097          	auipc	ra,0x5
    80001b76:	c6a080e7          	jalr	-918(ra) # 800067dc <initlock>
}
    80001b7a:	60a2                	ld	ra,8(sp)
    80001b7c:	6402                	ld	s0,0(sp)
    80001b7e:	0141                	addi	sp,sp,16
    80001b80:	8082                	ret

0000000080001b82 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001b82:	1141                	addi	sp,sp,-16
    80001b84:	e422                	sd	s0,8(sp)
    80001b86:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001b88:	00003797          	auipc	a5,0x3
    80001b8c:	67878793          	addi	a5,a5,1656 # 80005200 <kernelvec>
    80001b90:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001b94:	6422                	ld	s0,8(sp)
    80001b96:	0141                	addi	sp,sp,16
    80001b98:	8082                	ret

0000000080001b9a <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001b9a:	1141                	addi	sp,sp,-16
    80001b9c:	e406                	sd	ra,8(sp)
    80001b9e:	e022                	sd	s0,0(sp)
    80001ba0:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001ba2:	fffff097          	auipc	ra,0xfffff
    80001ba6:	394080e7          	jalr	916(ra) # 80000f36 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001baa:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001bae:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001bb0:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80001bb4:	00005617          	auipc	a2,0x5
    80001bb8:	44c60613          	addi	a2,a2,1100 # 80007000 <_trampoline>
    80001bbc:	00005697          	auipc	a3,0x5
    80001bc0:	44468693          	addi	a3,a3,1092 # 80007000 <_trampoline>
    80001bc4:	8e91                	sub	a3,a3,a2
    80001bc6:	040007b7          	lui	a5,0x4000
    80001bca:	17fd                	addi	a5,a5,-1
    80001bcc:	07b2                	slli	a5,a5,0xc
    80001bce:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001bd0:	10569073          	csrw	stvec,a3

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001bd4:	7138                	ld	a4,96(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001bd6:	180026f3          	csrr	a3,satp
    80001bda:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001bdc:	7138                	ld	a4,96(a0)
    80001bde:	6534                	ld	a3,72(a0)
    80001be0:	6585                	lui	a1,0x1
    80001be2:	96ae                	add	a3,a3,a1
    80001be4:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001be6:	7138                	ld	a4,96(a0)
    80001be8:	00000697          	auipc	a3,0x0
    80001bec:	13868693          	addi	a3,a3,312 # 80001d20 <usertrap>
    80001bf0:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001bf2:	7138                	ld	a4,96(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001bf4:	8692                	mv	a3,tp
    80001bf6:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001bf8:	100026f3          	csrr	a3,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001bfc:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001c00:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001c04:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001c08:	7138                	ld	a4,96(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001c0a:	6f18                	ld	a4,24(a4)
    80001c0c:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001c10:	6d2c                	ld	a1,88(a0)
    80001c12:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80001c14:	00005717          	auipc	a4,0x5
    80001c18:	47c70713          	addi	a4,a4,1148 # 80007090 <userret>
    80001c1c:	8f11                	sub	a4,a4,a2
    80001c1e:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80001c20:	577d                	li	a4,-1
    80001c22:	177e                	slli	a4,a4,0x3f
    80001c24:	8dd9                	or	a1,a1,a4
    80001c26:	02000537          	lui	a0,0x2000
    80001c2a:	157d                	addi	a0,a0,-1
    80001c2c:	0536                	slli	a0,a0,0xd
    80001c2e:	9782                	jalr	a5
}
    80001c30:	60a2                	ld	ra,8(sp)
    80001c32:	6402                	ld	s0,0(sp)
    80001c34:	0141                	addi	sp,sp,16
    80001c36:	8082                	ret

0000000080001c38 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001c38:	1101                	addi	sp,sp,-32
    80001c3a:	ec06                	sd	ra,24(sp)
    80001c3c:	e822                	sd	s0,16(sp)
    80001c3e:	e426                	sd	s1,8(sp)
    80001c40:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80001c42:	0000d497          	auipc	s1,0xd
    80001c46:	56e48493          	addi	s1,s1,1390 # 8000f1b0 <tickslock>
    80001c4a:	8526                	mv	a0,s1
    80001c4c:	00005097          	auipc	ra,0x5
    80001c50:	a14080e7          	jalr	-1516(ra) # 80006660 <acquire>
  ticks++;
    80001c54:	00007517          	auipc	a0,0x7
    80001c58:	3c450513          	addi	a0,a0,964 # 80009018 <ticks>
    80001c5c:	411c                	lw	a5,0(a0)
    80001c5e:	2785                	addiw	a5,a5,1
    80001c60:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80001c62:	00000097          	auipc	ra,0x0
    80001c66:	b1c080e7          	jalr	-1252(ra) # 8000177e <wakeup>
  release(&tickslock);
    80001c6a:	8526                	mv	a0,s1
    80001c6c:	00005097          	auipc	ra,0x5
    80001c70:	ac4080e7          	jalr	-1340(ra) # 80006730 <release>
}
    80001c74:	60e2                	ld	ra,24(sp)
    80001c76:	6442                	ld	s0,16(sp)
    80001c78:	64a2                	ld	s1,8(sp)
    80001c7a:	6105                	addi	sp,sp,32
    80001c7c:	8082                	ret

0000000080001c7e <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80001c7e:	1101                	addi	sp,sp,-32
    80001c80:	ec06                	sd	ra,24(sp)
    80001c82:	e822                	sd	s0,16(sp)
    80001c84:	e426                	sd	s1,8(sp)
    80001c86:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001c88:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    80001c8c:	00074d63          	bltz	a4,80001ca6 <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    80001c90:	57fd                	li	a5,-1
    80001c92:	17fe                	slli	a5,a5,0x3f
    80001c94:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001c96:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80001c98:	06f70363          	beq	a4,a5,80001cfe <devintr+0x80>
  }
}
    80001c9c:	60e2                	ld	ra,24(sp)
    80001c9e:	6442                	ld	s0,16(sp)
    80001ca0:	64a2                	ld	s1,8(sp)
    80001ca2:	6105                	addi	sp,sp,32
    80001ca4:	8082                	ret
     (scause & 0xff) == 9){
    80001ca6:	0ff77793          	andi	a5,a4,255
  if((scause & 0x8000000000000000L) &&
    80001caa:	46a5                	li	a3,9
    80001cac:	fed792e3          	bne	a5,a3,80001c90 <devintr+0x12>
    int irq = plic_claim();
    80001cb0:	00003097          	auipc	ra,0x3
    80001cb4:	658080e7          	jalr	1624(ra) # 80005308 <plic_claim>
    80001cb8:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001cba:	47a9                	li	a5,10
    80001cbc:	02f50763          	beq	a0,a5,80001cea <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    80001cc0:	4785                	li	a5,1
    80001cc2:	02f50963          	beq	a0,a5,80001cf4 <devintr+0x76>
    return 1;
    80001cc6:	4505                	li	a0,1
    } else if(irq){
    80001cc8:	d8f1                	beqz	s1,80001c9c <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    80001cca:	85a6                	mv	a1,s1
    80001ccc:	00006517          	auipc	a0,0x6
    80001cd0:	5ac50513          	addi	a0,a0,1452 # 80008278 <states.1728+0x38>
    80001cd4:	00004097          	auipc	ra,0x4
    80001cd8:	4a2080e7          	jalr	1186(ra) # 80006176 <printf>
      plic_complete(irq);
    80001cdc:	8526                	mv	a0,s1
    80001cde:	00003097          	auipc	ra,0x3
    80001ce2:	64e080e7          	jalr	1614(ra) # 8000532c <plic_complete>
    return 1;
    80001ce6:	4505                	li	a0,1
    80001ce8:	bf55                	j	80001c9c <devintr+0x1e>
      uartintr();
    80001cea:	00005097          	auipc	ra,0x5
    80001cee:	8ac080e7          	jalr	-1876(ra) # 80006596 <uartintr>
    80001cf2:	b7ed                	j	80001cdc <devintr+0x5e>
      virtio_disk_intr();
    80001cf4:	00004097          	auipc	ra,0x4
    80001cf8:	b18080e7          	jalr	-1256(ra) # 8000580c <virtio_disk_intr>
    80001cfc:	b7c5                	j	80001cdc <devintr+0x5e>
    if(cpuid() == 0){
    80001cfe:	fffff097          	auipc	ra,0xfffff
    80001d02:	20c080e7          	jalr	524(ra) # 80000f0a <cpuid>
    80001d06:	c901                	beqz	a0,80001d16 <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80001d08:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80001d0c:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80001d0e:	14479073          	csrw	sip,a5
    return 2;
    80001d12:	4509                	li	a0,2
    80001d14:	b761                	j	80001c9c <devintr+0x1e>
      clockintr();
    80001d16:	00000097          	auipc	ra,0x0
    80001d1a:	f22080e7          	jalr	-222(ra) # 80001c38 <clockintr>
    80001d1e:	b7ed                	j	80001d08 <devintr+0x8a>

0000000080001d20 <usertrap>:
{
    80001d20:	1101                	addi	sp,sp,-32
    80001d22:	ec06                	sd	ra,24(sp)
    80001d24:	e822                	sd	s0,16(sp)
    80001d26:	e426                	sd	s1,8(sp)
    80001d28:	e04a                	sd	s2,0(sp)
    80001d2a:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001d2c:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001d30:	1007f793          	andi	a5,a5,256
    80001d34:	e3ad                	bnez	a5,80001d96 <usertrap+0x76>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001d36:	00003797          	auipc	a5,0x3
    80001d3a:	4ca78793          	addi	a5,a5,1226 # 80005200 <kernelvec>
    80001d3e:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001d42:	fffff097          	auipc	ra,0xfffff
    80001d46:	1f4080e7          	jalr	500(ra) # 80000f36 <myproc>
    80001d4a:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001d4c:	713c                	ld	a5,96(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001d4e:	14102773          	csrr	a4,sepc
    80001d52:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001d54:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001d58:	47a1                	li	a5,8
    80001d5a:	04f71c63          	bne	a4,a5,80001db2 <usertrap+0x92>
    if(p->killed)
    80001d5e:	591c                	lw	a5,48(a0)
    80001d60:	e3b9                	bnez	a5,80001da6 <usertrap+0x86>
    p->trapframe->epc += 4;
    80001d62:	70b8                	ld	a4,96(s1)
    80001d64:	6f1c                	ld	a5,24(a4)
    80001d66:	0791                	addi	a5,a5,4
    80001d68:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001d6a:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001d6e:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001d72:	10079073          	csrw	sstatus,a5
    syscall();
    80001d76:	00000097          	auipc	ra,0x0
    80001d7a:	2e0080e7          	jalr	736(ra) # 80002056 <syscall>
  if(p->killed)
    80001d7e:	589c                	lw	a5,48(s1)
    80001d80:	ebc1                	bnez	a5,80001e10 <usertrap+0xf0>
  usertrapret();
    80001d82:	00000097          	auipc	ra,0x0
    80001d86:	e18080e7          	jalr	-488(ra) # 80001b9a <usertrapret>
}
    80001d8a:	60e2                	ld	ra,24(sp)
    80001d8c:	6442                	ld	s0,16(sp)
    80001d8e:	64a2                	ld	s1,8(sp)
    80001d90:	6902                	ld	s2,0(sp)
    80001d92:	6105                	addi	sp,sp,32
    80001d94:	8082                	ret
    panic("usertrap: not from user mode");
    80001d96:	00006517          	auipc	a0,0x6
    80001d9a:	50250513          	addi	a0,a0,1282 # 80008298 <states.1728+0x58>
    80001d9e:	00004097          	auipc	ra,0x4
    80001da2:	38e080e7          	jalr	910(ra) # 8000612c <panic>
      exit(-1);
    80001da6:	557d                	li	a0,-1
    80001da8:	00000097          	auipc	ra,0x0
    80001dac:	aa6080e7          	jalr	-1370(ra) # 8000184e <exit>
    80001db0:	bf4d                	j	80001d62 <usertrap+0x42>
  } else if((which_dev = devintr()) != 0){
    80001db2:	00000097          	auipc	ra,0x0
    80001db6:	ecc080e7          	jalr	-308(ra) # 80001c7e <devintr>
    80001dba:	892a                	mv	s2,a0
    80001dbc:	c501                	beqz	a0,80001dc4 <usertrap+0xa4>
  if(p->killed)
    80001dbe:	589c                	lw	a5,48(s1)
    80001dc0:	c3a1                	beqz	a5,80001e00 <usertrap+0xe0>
    80001dc2:	a815                	j	80001df6 <usertrap+0xd6>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001dc4:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80001dc8:	5c90                	lw	a2,56(s1)
    80001dca:	00006517          	auipc	a0,0x6
    80001dce:	4ee50513          	addi	a0,a0,1262 # 800082b8 <states.1728+0x78>
    80001dd2:	00004097          	auipc	ra,0x4
    80001dd6:	3a4080e7          	jalr	932(ra) # 80006176 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001dda:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001dde:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001de2:	00006517          	auipc	a0,0x6
    80001de6:	50650513          	addi	a0,a0,1286 # 800082e8 <states.1728+0xa8>
    80001dea:	00004097          	auipc	ra,0x4
    80001dee:	38c080e7          	jalr	908(ra) # 80006176 <printf>
    p->killed = 1;
    80001df2:	4785                	li	a5,1
    80001df4:	d89c                	sw	a5,48(s1)
    exit(-1);
    80001df6:	557d                	li	a0,-1
    80001df8:	00000097          	auipc	ra,0x0
    80001dfc:	a56080e7          	jalr	-1450(ra) # 8000184e <exit>
  if(which_dev == 2)
    80001e00:	4789                	li	a5,2
    80001e02:	f8f910e3          	bne	s2,a5,80001d82 <usertrap+0x62>
    yield();
    80001e06:	fffff097          	auipc	ra,0xfffff
    80001e0a:	7b0080e7          	jalr	1968(ra) # 800015b6 <yield>
    80001e0e:	bf95                	j	80001d82 <usertrap+0x62>
  int which_dev = 0;
    80001e10:	4901                	li	s2,0
    80001e12:	b7d5                	j	80001df6 <usertrap+0xd6>

0000000080001e14 <kerneltrap>:
{
    80001e14:	7179                	addi	sp,sp,-48
    80001e16:	f406                	sd	ra,40(sp)
    80001e18:	f022                	sd	s0,32(sp)
    80001e1a:	ec26                	sd	s1,24(sp)
    80001e1c:	e84a                	sd	s2,16(sp)
    80001e1e:	e44e                	sd	s3,8(sp)
    80001e20:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001e22:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001e26:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001e2a:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80001e2e:	1004f793          	andi	a5,s1,256
    80001e32:	cb85                	beqz	a5,80001e62 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001e34:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001e38:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80001e3a:	ef85                	bnez	a5,80001e72 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80001e3c:	00000097          	auipc	ra,0x0
    80001e40:	e42080e7          	jalr	-446(ra) # 80001c7e <devintr>
    80001e44:	cd1d                	beqz	a0,80001e82 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001e46:	4789                	li	a5,2
    80001e48:	06f50a63          	beq	a0,a5,80001ebc <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001e4c:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001e50:	10049073          	csrw	sstatus,s1
}
    80001e54:	70a2                	ld	ra,40(sp)
    80001e56:	7402                	ld	s0,32(sp)
    80001e58:	64e2                	ld	s1,24(sp)
    80001e5a:	6942                	ld	s2,16(sp)
    80001e5c:	69a2                	ld	s3,8(sp)
    80001e5e:	6145                	addi	sp,sp,48
    80001e60:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001e62:	00006517          	auipc	a0,0x6
    80001e66:	4a650513          	addi	a0,a0,1190 # 80008308 <states.1728+0xc8>
    80001e6a:	00004097          	auipc	ra,0x4
    80001e6e:	2c2080e7          	jalr	706(ra) # 8000612c <panic>
    panic("kerneltrap: interrupts enabled");
    80001e72:	00006517          	auipc	a0,0x6
    80001e76:	4be50513          	addi	a0,a0,1214 # 80008330 <states.1728+0xf0>
    80001e7a:	00004097          	auipc	ra,0x4
    80001e7e:	2b2080e7          	jalr	690(ra) # 8000612c <panic>
    printf("scause %p\n", scause);
    80001e82:	85ce                	mv	a1,s3
    80001e84:	00006517          	auipc	a0,0x6
    80001e88:	4cc50513          	addi	a0,a0,1228 # 80008350 <states.1728+0x110>
    80001e8c:	00004097          	auipc	ra,0x4
    80001e90:	2ea080e7          	jalr	746(ra) # 80006176 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001e94:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001e98:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001e9c:	00006517          	auipc	a0,0x6
    80001ea0:	4c450513          	addi	a0,a0,1220 # 80008360 <states.1728+0x120>
    80001ea4:	00004097          	auipc	ra,0x4
    80001ea8:	2d2080e7          	jalr	722(ra) # 80006176 <printf>
    panic("kerneltrap");
    80001eac:	00006517          	auipc	a0,0x6
    80001eb0:	4cc50513          	addi	a0,a0,1228 # 80008378 <states.1728+0x138>
    80001eb4:	00004097          	auipc	ra,0x4
    80001eb8:	278080e7          	jalr	632(ra) # 8000612c <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001ebc:	fffff097          	auipc	ra,0xfffff
    80001ec0:	07a080e7          	jalr	122(ra) # 80000f36 <myproc>
    80001ec4:	d541                	beqz	a0,80001e4c <kerneltrap+0x38>
    80001ec6:	fffff097          	auipc	ra,0xfffff
    80001eca:	070080e7          	jalr	112(ra) # 80000f36 <myproc>
    80001ece:	5118                	lw	a4,32(a0)
    80001ed0:	4791                	li	a5,4
    80001ed2:	f6f71de3          	bne	a4,a5,80001e4c <kerneltrap+0x38>
    yield();
    80001ed6:	fffff097          	auipc	ra,0xfffff
    80001eda:	6e0080e7          	jalr	1760(ra) # 800015b6 <yield>
    80001ede:	b7bd                	j	80001e4c <kerneltrap+0x38>

0000000080001ee0 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80001ee0:	1101                	addi	sp,sp,-32
    80001ee2:	ec06                	sd	ra,24(sp)
    80001ee4:	e822                	sd	s0,16(sp)
    80001ee6:	e426                	sd	s1,8(sp)
    80001ee8:	1000                	addi	s0,sp,32
    80001eea:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001eec:	fffff097          	auipc	ra,0xfffff
    80001ef0:	04a080e7          	jalr	74(ra) # 80000f36 <myproc>
  switch (n) {
    80001ef4:	4795                	li	a5,5
    80001ef6:	0497e163          	bltu	a5,s1,80001f38 <argraw+0x58>
    80001efa:	048a                	slli	s1,s1,0x2
    80001efc:	00006717          	auipc	a4,0x6
    80001f00:	4b470713          	addi	a4,a4,1204 # 800083b0 <states.1728+0x170>
    80001f04:	94ba                	add	s1,s1,a4
    80001f06:	409c                	lw	a5,0(s1)
    80001f08:	97ba                	add	a5,a5,a4
    80001f0a:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80001f0c:	713c                	ld	a5,96(a0)
    80001f0e:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80001f10:	60e2                	ld	ra,24(sp)
    80001f12:	6442                	ld	s0,16(sp)
    80001f14:	64a2                	ld	s1,8(sp)
    80001f16:	6105                	addi	sp,sp,32
    80001f18:	8082                	ret
    return p->trapframe->a1;
    80001f1a:	713c                	ld	a5,96(a0)
    80001f1c:	7fa8                	ld	a0,120(a5)
    80001f1e:	bfcd                	j	80001f10 <argraw+0x30>
    return p->trapframe->a2;
    80001f20:	713c                	ld	a5,96(a0)
    80001f22:	63c8                	ld	a0,128(a5)
    80001f24:	b7f5                	j	80001f10 <argraw+0x30>
    return p->trapframe->a3;
    80001f26:	713c                	ld	a5,96(a0)
    80001f28:	67c8                	ld	a0,136(a5)
    80001f2a:	b7dd                	j	80001f10 <argraw+0x30>
    return p->trapframe->a4;
    80001f2c:	713c                	ld	a5,96(a0)
    80001f2e:	6bc8                	ld	a0,144(a5)
    80001f30:	b7c5                	j	80001f10 <argraw+0x30>
    return p->trapframe->a5;
    80001f32:	713c                	ld	a5,96(a0)
    80001f34:	6fc8                	ld	a0,152(a5)
    80001f36:	bfe9                	j	80001f10 <argraw+0x30>
  panic("argraw");
    80001f38:	00006517          	auipc	a0,0x6
    80001f3c:	45050513          	addi	a0,a0,1104 # 80008388 <states.1728+0x148>
    80001f40:	00004097          	auipc	ra,0x4
    80001f44:	1ec080e7          	jalr	492(ra) # 8000612c <panic>

0000000080001f48 <fetchaddr>:
{
    80001f48:	1101                	addi	sp,sp,-32
    80001f4a:	ec06                	sd	ra,24(sp)
    80001f4c:	e822                	sd	s0,16(sp)
    80001f4e:	e426                	sd	s1,8(sp)
    80001f50:	e04a                	sd	s2,0(sp)
    80001f52:	1000                	addi	s0,sp,32
    80001f54:	84aa                	mv	s1,a0
    80001f56:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001f58:	fffff097          	auipc	ra,0xfffff
    80001f5c:	fde080e7          	jalr	-34(ra) # 80000f36 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80001f60:	693c                	ld	a5,80(a0)
    80001f62:	02f4f863          	bgeu	s1,a5,80001f92 <fetchaddr+0x4a>
    80001f66:	00848713          	addi	a4,s1,8
    80001f6a:	02e7e663          	bltu	a5,a4,80001f96 <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80001f6e:	46a1                	li	a3,8
    80001f70:	8626                	mv	a2,s1
    80001f72:	85ca                	mv	a1,s2
    80001f74:	6d28                	ld	a0,88(a0)
    80001f76:	fffff097          	auipc	ra,0xfffff
    80001f7a:	d0e080e7          	jalr	-754(ra) # 80000c84 <copyin>
    80001f7e:	00a03533          	snez	a0,a0
    80001f82:	40a00533          	neg	a0,a0
}
    80001f86:	60e2                	ld	ra,24(sp)
    80001f88:	6442                	ld	s0,16(sp)
    80001f8a:	64a2                	ld	s1,8(sp)
    80001f8c:	6902                	ld	s2,0(sp)
    80001f8e:	6105                	addi	sp,sp,32
    80001f90:	8082                	ret
    return -1;
    80001f92:	557d                	li	a0,-1
    80001f94:	bfcd                	j	80001f86 <fetchaddr+0x3e>
    80001f96:	557d                	li	a0,-1
    80001f98:	b7fd                	j	80001f86 <fetchaddr+0x3e>

0000000080001f9a <fetchstr>:
{
    80001f9a:	7179                	addi	sp,sp,-48
    80001f9c:	f406                	sd	ra,40(sp)
    80001f9e:	f022                	sd	s0,32(sp)
    80001fa0:	ec26                	sd	s1,24(sp)
    80001fa2:	e84a                	sd	s2,16(sp)
    80001fa4:	e44e                	sd	s3,8(sp)
    80001fa6:	1800                	addi	s0,sp,48
    80001fa8:	892a                	mv	s2,a0
    80001faa:	84ae                	mv	s1,a1
    80001fac:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80001fae:	fffff097          	auipc	ra,0xfffff
    80001fb2:	f88080e7          	jalr	-120(ra) # 80000f36 <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    80001fb6:	86ce                	mv	a3,s3
    80001fb8:	864a                	mv	a2,s2
    80001fba:	85a6                	mv	a1,s1
    80001fbc:	6d28                	ld	a0,88(a0)
    80001fbe:	fffff097          	auipc	ra,0xfffff
    80001fc2:	d52080e7          	jalr	-686(ra) # 80000d10 <copyinstr>
  if(err < 0)
    80001fc6:	00054763          	bltz	a0,80001fd4 <fetchstr+0x3a>
  return strlen(buf);
    80001fca:	8526                	mv	a0,s1
    80001fcc:	ffffe097          	auipc	ra,0xffffe
    80001fd0:	40e080e7          	jalr	1038(ra) # 800003da <strlen>
}
    80001fd4:	70a2                	ld	ra,40(sp)
    80001fd6:	7402                	ld	s0,32(sp)
    80001fd8:	64e2                	ld	s1,24(sp)
    80001fda:	6942                	ld	s2,16(sp)
    80001fdc:	69a2                	ld	s3,8(sp)
    80001fde:	6145                	addi	sp,sp,48
    80001fe0:	8082                	ret

0000000080001fe2 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80001fe2:	1101                	addi	sp,sp,-32
    80001fe4:	ec06                	sd	ra,24(sp)
    80001fe6:	e822                	sd	s0,16(sp)
    80001fe8:	e426                	sd	s1,8(sp)
    80001fea:	1000                	addi	s0,sp,32
    80001fec:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001fee:	00000097          	auipc	ra,0x0
    80001ff2:	ef2080e7          	jalr	-270(ra) # 80001ee0 <argraw>
    80001ff6:	c088                	sw	a0,0(s1)
  return 0;
}
    80001ff8:	4501                	li	a0,0
    80001ffa:	60e2                	ld	ra,24(sp)
    80001ffc:	6442                	ld	s0,16(sp)
    80001ffe:	64a2                	ld	s1,8(sp)
    80002000:	6105                	addi	sp,sp,32
    80002002:	8082                	ret

0000000080002004 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80002004:	1101                	addi	sp,sp,-32
    80002006:	ec06                	sd	ra,24(sp)
    80002008:	e822                	sd	s0,16(sp)
    8000200a:	e426                	sd	s1,8(sp)
    8000200c:	1000                	addi	s0,sp,32
    8000200e:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002010:	00000097          	auipc	ra,0x0
    80002014:	ed0080e7          	jalr	-304(ra) # 80001ee0 <argraw>
    80002018:	e088                	sd	a0,0(s1)
  return 0;
}
    8000201a:	4501                	li	a0,0
    8000201c:	60e2                	ld	ra,24(sp)
    8000201e:	6442                	ld	s0,16(sp)
    80002020:	64a2                	ld	s1,8(sp)
    80002022:	6105                	addi	sp,sp,32
    80002024:	8082                	ret

0000000080002026 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80002026:	1101                	addi	sp,sp,-32
    80002028:	ec06                	sd	ra,24(sp)
    8000202a:	e822                	sd	s0,16(sp)
    8000202c:	e426                	sd	s1,8(sp)
    8000202e:	e04a                	sd	s2,0(sp)
    80002030:	1000                	addi	s0,sp,32
    80002032:	84ae                	mv	s1,a1
    80002034:	8932                	mv	s2,a2
  *ip = argraw(n);
    80002036:	00000097          	auipc	ra,0x0
    8000203a:	eaa080e7          	jalr	-342(ra) # 80001ee0 <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    8000203e:	864a                	mv	a2,s2
    80002040:	85a6                	mv	a1,s1
    80002042:	00000097          	auipc	ra,0x0
    80002046:	f58080e7          	jalr	-168(ra) # 80001f9a <fetchstr>
}
    8000204a:	60e2                	ld	ra,24(sp)
    8000204c:	6442                	ld	s0,16(sp)
    8000204e:	64a2                	ld	s1,8(sp)
    80002050:	6902                	ld	s2,0(sp)
    80002052:	6105                	addi	sp,sp,32
    80002054:	8082                	ret

0000000080002056 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
    80002056:	1101                	addi	sp,sp,-32
    80002058:	ec06                	sd	ra,24(sp)
    8000205a:	e822                	sd	s0,16(sp)
    8000205c:	e426                	sd	s1,8(sp)
    8000205e:	e04a                	sd	s2,0(sp)
    80002060:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80002062:	fffff097          	auipc	ra,0xfffff
    80002066:	ed4080e7          	jalr	-300(ra) # 80000f36 <myproc>
    8000206a:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    8000206c:	06053903          	ld	s2,96(a0)
    80002070:	0a893783          	ld	a5,168(s2)
    80002074:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002078:	37fd                	addiw	a5,a5,-1
    8000207a:	4751                	li	a4,20
    8000207c:	00f76f63          	bltu	a4,a5,8000209a <syscall+0x44>
    80002080:	00369713          	slli	a4,a3,0x3
    80002084:	00006797          	auipc	a5,0x6
    80002088:	34478793          	addi	a5,a5,836 # 800083c8 <syscalls>
    8000208c:	97ba                	add	a5,a5,a4
    8000208e:	639c                	ld	a5,0(a5)
    80002090:	c789                	beqz	a5,8000209a <syscall+0x44>
    p->trapframe->a0 = syscalls[num]();
    80002092:	9782                	jalr	a5
    80002094:	06a93823          	sd	a0,112(s2)
    80002098:	a839                	j	800020b6 <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    8000209a:	16048613          	addi	a2,s1,352
    8000209e:	5c8c                	lw	a1,56(s1)
    800020a0:	00006517          	auipc	a0,0x6
    800020a4:	2f050513          	addi	a0,a0,752 # 80008390 <states.1728+0x150>
    800020a8:	00004097          	auipc	ra,0x4
    800020ac:	0ce080e7          	jalr	206(ra) # 80006176 <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    800020b0:	70bc                	ld	a5,96(s1)
    800020b2:	577d                	li	a4,-1
    800020b4:	fbb8                	sd	a4,112(a5)
  }
}
    800020b6:	60e2                	ld	ra,24(sp)
    800020b8:	6442                	ld	s0,16(sp)
    800020ba:	64a2                	ld	s1,8(sp)
    800020bc:	6902                	ld	s2,0(sp)
    800020be:	6105                	addi	sp,sp,32
    800020c0:	8082                	ret

00000000800020c2 <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    800020c2:	1101                	addi	sp,sp,-32
    800020c4:	ec06                	sd	ra,24(sp)
    800020c6:	e822                	sd	s0,16(sp)
    800020c8:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    800020ca:	fec40593          	addi	a1,s0,-20
    800020ce:	4501                	li	a0,0
    800020d0:	00000097          	auipc	ra,0x0
    800020d4:	f12080e7          	jalr	-238(ra) # 80001fe2 <argint>
    return -1;
    800020d8:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    800020da:	00054963          	bltz	a0,800020ec <sys_exit+0x2a>
  exit(n);
    800020de:	fec42503          	lw	a0,-20(s0)
    800020e2:	fffff097          	auipc	ra,0xfffff
    800020e6:	76c080e7          	jalr	1900(ra) # 8000184e <exit>
  return 0;  // not reached
    800020ea:	4781                	li	a5,0
}
    800020ec:	853e                	mv	a0,a5
    800020ee:	60e2                	ld	ra,24(sp)
    800020f0:	6442                	ld	s0,16(sp)
    800020f2:	6105                	addi	sp,sp,32
    800020f4:	8082                	ret

00000000800020f6 <sys_getpid>:

uint64
sys_getpid(void)
{
    800020f6:	1141                	addi	sp,sp,-16
    800020f8:	e406                	sd	ra,8(sp)
    800020fa:	e022                	sd	s0,0(sp)
    800020fc:	0800                	addi	s0,sp,16
  return myproc()->pid;
    800020fe:	fffff097          	auipc	ra,0xfffff
    80002102:	e38080e7          	jalr	-456(ra) # 80000f36 <myproc>
}
    80002106:	5d08                	lw	a0,56(a0)
    80002108:	60a2                	ld	ra,8(sp)
    8000210a:	6402                	ld	s0,0(sp)
    8000210c:	0141                	addi	sp,sp,16
    8000210e:	8082                	ret

0000000080002110 <sys_fork>:

uint64
sys_fork(void)
{
    80002110:	1141                	addi	sp,sp,-16
    80002112:	e406                	sd	ra,8(sp)
    80002114:	e022                	sd	s0,0(sp)
    80002116:	0800                	addi	s0,sp,16
  return fork();
    80002118:	fffff097          	auipc	ra,0xfffff
    8000211c:	1ec080e7          	jalr	492(ra) # 80001304 <fork>
}
    80002120:	60a2                	ld	ra,8(sp)
    80002122:	6402                	ld	s0,0(sp)
    80002124:	0141                	addi	sp,sp,16
    80002126:	8082                	ret

0000000080002128 <sys_wait>:

uint64
sys_wait(void)
{
    80002128:	1101                	addi	sp,sp,-32
    8000212a:	ec06                	sd	ra,24(sp)
    8000212c:	e822                	sd	s0,16(sp)
    8000212e:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    80002130:	fe840593          	addi	a1,s0,-24
    80002134:	4501                	li	a0,0
    80002136:	00000097          	auipc	ra,0x0
    8000213a:	ece080e7          	jalr	-306(ra) # 80002004 <argaddr>
    8000213e:	87aa                	mv	a5,a0
    return -1;
    80002140:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    80002142:	0007c863          	bltz	a5,80002152 <sys_wait+0x2a>
  return wait(p);
    80002146:	fe843503          	ld	a0,-24(s0)
    8000214a:	fffff097          	auipc	ra,0xfffff
    8000214e:	50c080e7          	jalr	1292(ra) # 80001656 <wait>
}
    80002152:	60e2                	ld	ra,24(sp)
    80002154:	6442                	ld	s0,16(sp)
    80002156:	6105                	addi	sp,sp,32
    80002158:	8082                	ret

000000008000215a <sys_sbrk>:

uint64
sys_sbrk(void)
{
    8000215a:	7179                	addi	sp,sp,-48
    8000215c:	f406                	sd	ra,40(sp)
    8000215e:	f022                	sd	s0,32(sp)
    80002160:	ec26                	sd	s1,24(sp)
    80002162:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    80002164:	fdc40593          	addi	a1,s0,-36
    80002168:	4501                	li	a0,0
    8000216a:	00000097          	auipc	ra,0x0
    8000216e:	e78080e7          	jalr	-392(ra) # 80001fe2 <argint>
    80002172:	87aa                	mv	a5,a0
    return -1;
    80002174:	557d                	li	a0,-1
  if(argint(0, &n) < 0)
    80002176:	0207c063          	bltz	a5,80002196 <sys_sbrk+0x3c>
  addr = myproc()->sz;
    8000217a:	fffff097          	auipc	ra,0xfffff
    8000217e:	dbc080e7          	jalr	-580(ra) # 80000f36 <myproc>
    80002182:	4924                	lw	s1,80(a0)
  if(growproc(n) < 0)
    80002184:	fdc42503          	lw	a0,-36(s0)
    80002188:	fffff097          	auipc	ra,0xfffff
    8000218c:	108080e7          	jalr	264(ra) # 80001290 <growproc>
    80002190:	00054863          	bltz	a0,800021a0 <sys_sbrk+0x46>
    return -1;
  return addr;
    80002194:	8526                	mv	a0,s1
}
    80002196:	70a2                	ld	ra,40(sp)
    80002198:	7402                	ld	s0,32(sp)
    8000219a:	64e2                	ld	s1,24(sp)
    8000219c:	6145                	addi	sp,sp,48
    8000219e:	8082                	ret
    return -1;
    800021a0:	557d                	li	a0,-1
    800021a2:	bfd5                	j	80002196 <sys_sbrk+0x3c>

00000000800021a4 <sys_sleep>:

uint64
sys_sleep(void)
{
    800021a4:	7139                	addi	sp,sp,-64
    800021a6:	fc06                	sd	ra,56(sp)
    800021a8:	f822                	sd	s0,48(sp)
    800021aa:	f426                	sd	s1,40(sp)
    800021ac:	f04a                	sd	s2,32(sp)
    800021ae:	ec4e                	sd	s3,24(sp)
    800021b0:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    800021b2:	fcc40593          	addi	a1,s0,-52
    800021b6:	4501                	li	a0,0
    800021b8:	00000097          	auipc	ra,0x0
    800021bc:	e2a080e7          	jalr	-470(ra) # 80001fe2 <argint>
    return -1;
    800021c0:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    800021c2:	06054563          	bltz	a0,8000222c <sys_sleep+0x88>
  acquire(&tickslock);
    800021c6:	0000d517          	auipc	a0,0xd
    800021ca:	fea50513          	addi	a0,a0,-22 # 8000f1b0 <tickslock>
    800021ce:	00004097          	auipc	ra,0x4
    800021d2:	492080e7          	jalr	1170(ra) # 80006660 <acquire>
  ticks0 = ticks;
    800021d6:	00007917          	auipc	s2,0x7
    800021da:	e4292903          	lw	s2,-446(s2) # 80009018 <ticks>
  while(ticks - ticks0 < n){
    800021de:	fcc42783          	lw	a5,-52(s0)
    800021e2:	cf85                	beqz	a5,8000221a <sys_sleep+0x76>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    800021e4:	0000d997          	auipc	s3,0xd
    800021e8:	fcc98993          	addi	s3,s3,-52 # 8000f1b0 <tickslock>
    800021ec:	00007497          	auipc	s1,0x7
    800021f0:	e2c48493          	addi	s1,s1,-468 # 80009018 <ticks>
    if(myproc()->killed){
    800021f4:	fffff097          	auipc	ra,0xfffff
    800021f8:	d42080e7          	jalr	-702(ra) # 80000f36 <myproc>
    800021fc:	591c                	lw	a5,48(a0)
    800021fe:	ef9d                	bnez	a5,8000223c <sys_sleep+0x98>
    sleep(&ticks, &tickslock);
    80002200:	85ce                	mv	a1,s3
    80002202:	8526                	mv	a0,s1
    80002204:	fffff097          	auipc	ra,0xfffff
    80002208:	3ee080e7          	jalr	1006(ra) # 800015f2 <sleep>
  while(ticks - ticks0 < n){
    8000220c:	409c                	lw	a5,0(s1)
    8000220e:	412787bb          	subw	a5,a5,s2
    80002212:	fcc42703          	lw	a4,-52(s0)
    80002216:	fce7efe3          	bltu	a5,a4,800021f4 <sys_sleep+0x50>
  }
  release(&tickslock);
    8000221a:	0000d517          	auipc	a0,0xd
    8000221e:	f9650513          	addi	a0,a0,-106 # 8000f1b0 <tickslock>
    80002222:	00004097          	auipc	ra,0x4
    80002226:	50e080e7          	jalr	1294(ra) # 80006730 <release>
  return 0;
    8000222a:	4781                	li	a5,0
}
    8000222c:	853e                	mv	a0,a5
    8000222e:	70e2                	ld	ra,56(sp)
    80002230:	7442                	ld	s0,48(sp)
    80002232:	74a2                	ld	s1,40(sp)
    80002234:	7902                	ld	s2,32(sp)
    80002236:	69e2                	ld	s3,24(sp)
    80002238:	6121                	addi	sp,sp,64
    8000223a:	8082                	ret
      release(&tickslock);
    8000223c:	0000d517          	auipc	a0,0xd
    80002240:	f7450513          	addi	a0,a0,-140 # 8000f1b0 <tickslock>
    80002244:	00004097          	auipc	ra,0x4
    80002248:	4ec080e7          	jalr	1260(ra) # 80006730 <release>
      return -1;
    8000224c:	57fd                	li	a5,-1
    8000224e:	bff9                	j	8000222c <sys_sleep+0x88>

0000000080002250 <sys_kill>:

uint64
sys_kill(void)
{
    80002250:	1101                	addi	sp,sp,-32
    80002252:	ec06                	sd	ra,24(sp)
    80002254:	e822                	sd	s0,16(sp)
    80002256:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80002258:	fec40593          	addi	a1,s0,-20
    8000225c:	4501                	li	a0,0
    8000225e:	00000097          	auipc	ra,0x0
    80002262:	d84080e7          	jalr	-636(ra) # 80001fe2 <argint>
    80002266:	87aa                	mv	a5,a0
    return -1;
    80002268:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    8000226a:	0007c863          	bltz	a5,8000227a <sys_kill+0x2a>
  return kill(pid);
    8000226e:	fec42503          	lw	a0,-20(s0)
    80002272:	fffff097          	auipc	ra,0xfffff
    80002276:	6b2080e7          	jalr	1714(ra) # 80001924 <kill>
}
    8000227a:	60e2                	ld	ra,24(sp)
    8000227c:	6442                	ld	s0,16(sp)
    8000227e:	6105                	addi	sp,sp,32
    80002280:	8082                	ret

0000000080002282 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80002282:	1101                	addi	sp,sp,-32
    80002284:	ec06                	sd	ra,24(sp)
    80002286:	e822                	sd	s0,16(sp)
    80002288:	e426                	sd	s1,8(sp)
    8000228a:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    8000228c:	0000d517          	auipc	a0,0xd
    80002290:	f2450513          	addi	a0,a0,-220 # 8000f1b0 <tickslock>
    80002294:	00004097          	auipc	ra,0x4
    80002298:	3cc080e7          	jalr	972(ra) # 80006660 <acquire>
  xticks = ticks;
    8000229c:	00007497          	auipc	s1,0x7
    800022a0:	d7c4a483          	lw	s1,-644(s1) # 80009018 <ticks>
  release(&tickslock);
    800022a4:	0000d517          	auipc	a0,0xd
    800022a8:	f0c50513          	addi	a0,a0,-244 # 8000f1b0 <tickslock>
    800022ac:	00004097          	auipc	ra,0x4
    800022b0:	484080e7          	jalr	1156(ra) # 80006730 <release>
  return xticks;
}
    800022b4:	02049513          	slli	a0,s1,0x20
    800022b8:	9101                	srli	a0,a0,0x20
    800022ba:	60e2                	ld	ra,24(sp)
    800022bc:	6442                	ld	s0,16(sp)
    800022be:	64a2                	ld	s1,8(sp)
    800022c0:	6105                	addi	sp,sp,32
    800022c2:	8082                	ret

00000000800022c4 <binit>:
  struct buf head[NBUCKET];
} bcache;

void
binit(void)
{
    800022c4:	7179                	addi	sp,sp,-48
    800022c6:	f406                	sd	ra,40(sp)
    800022c8:	f022                	sd	s0,32(sp)
    800022ca:	ec26                	sd	s1,24(sp)
    800022cc:	e84a                	sd	s2,16(sp)
    800022ce:	e44e                	sd	s3,8(sp)
    800022d0:	1800                	addi	s0,sp,48
  struct buf *b;

  for (int i=0;i<NBUCKET;i++)
    800022d2:	0000d497          	auipc	s1,0xd
    800022d6:	efe48493          	addi	s1,s1,-258 # 8000f1d0 <bcache>
    800022da:	0000d997          	auipc	s3,0xd
    800022de:	09698993          	addi	s3,s3,150 # 8000f370 <bcache+0x1a0>
  {
    initlock(&bcache.lock[i], "bcache");
    800022e2:	00006917          	auipc	s2,0x6
    800022e6:	19690913          	addi	s2,s2,406 # 80008478 <syscalls+0xb0>
    800022ea:	85ca                	mv	a1,s2
    800022ec:	8526                	mv	a0,s1
    800022ee:	00004097          	auipc	ra,0x4
    800022f2:	4ee080e7          	jalr	1262(ra) # 800067dc <initlock>
  for (int i=0;i<NBUCKET;i++)
    800022f6:	02048493          	addi	s1,s1,32
    800022fa:	ff3498e3          	bne	s1,s3,800022ea <binit+0x26>
  }
  // Create linked list of buffers
  // bcache.head[0].prev = &bcache.head[0];
  bcache.head[0].next = &bcache.buf[0];
    800022fe:	0000d497          	auipc	s1,0xd
    80002302:	07248493          	addi	s1,s1,114 # 8000f370 <bcache+0x1a0>
    80002306:	00015797          	auipc	a5,0x15
    8000230a:	4e97b923          	sd	s1,1266(a5) # 800177f8 <bcache+0x8628>
  for(b = bcache.buf; b < bcache.buf+NBUF-1; b++){
    b->next = b+1;
    initsleeplock(&b->lock, "buffer");
    8000230e:	00006997          	auipc	s3,0x6
    80002312:	17298993          	addi	s3,s3,370 # 80008480 <syscalls+0xb8>
  for(b = bcache.buf; b < bcache.buf+NBUF-1; b++){
    80002316:	00015917          	auipc	s2,0x15
    8000231a:	02290913          	addi	s2,s2,34 # 80017338 <bcache+0x8168>
    b->next = b+1;
    8000231e:	46848493          	addi	s1,s1,1128
    80002322:	be94b823          	sd	s1,-1040(s1)
    initsleeplock(&b->lock, "buffer");
    80002326:	85ce                	mv	a1,s3
    80002328:	ba848513          	addi	a0,s1,-1112
    8000232c:	00001097          	auipc	ra,0x1
    80002330:	6a0080e7          	jalr	1696(ra) # 800039cc <initsleeplock>
  for(b = bcache.buf; b < bcache.buf+NBUF-1; b++){
    80002334:	ff2495e3          	bne	s1,s2,8000231e <binit+0x5a>
  }
  initsleeplock(&b->lock, "buffer");
    80002338:	00006597          	auipc	a1,0x6
    8000233c:	14858593          	addi	a1,a1,328 # 80008480 <syscalls+0xb8>
    80002340:	00015517          	auipc	a0,0x15
    80002344:	00850513          	addi	a0,a0,8 # 80017348 <bcache+0x8178>
    80002348:	00001097          	auipc	ra,0x1
    8000234c:	684080e7          	jalr	1668(ra) # 800039cc <initsleeplock>
}
    80002350:	70a2                	ld	ra,40(sp)
    80002352:	7402                	ld	s0,32(sp)
    80002354:	64e2                	ld	s1,24(sp)
    80002356:	6942                	ld	s2,16(sp)
    80002358:	69a2                	ld	s3,8(sp)
    8000235a:	6145                	addi	sp,sp,48
    8000235c:	8082                	ret

000000008000235e <write_cache>:

// 参考 https://zhuanlan.zhihu.com/p/426507542
void
write_cache(struct buf *take_buf, uint dev, uint blockno)
{
    8000235e:	1141                	addi	sp,sp,-16
    80002360:	e422                	sd	s0,8(sp)
    80002362:	0800                	addi	s0,sp,16
  take_buf->dev = dev;
    80002364:	c50c                	sw	a1,8(a0)
  take_buf->blockno = blockno;
    80002366:	c550                	sw	a2,12(a0)
  take_buf->valid = 0;
    80002368:	00052023          	sw	zero,0(a0)
  take_buf->refcnt = 1;
    8000236c:	4785                	li	a5,1
    8000236e:	c53c                	sw	a5,72(a0)
  take_buf->time = ticks;
    80002370:	00007797          	auipc	a5,0x7
    80002374:	ca87a783          	lw	a5,-856(a5) # 80009018 <ticks>
    80002378:	46f52023          	sw	a5,1120(a0)
}
    8000237c:	6422                	ld	s0,8(sp)
    8000237e:	0141                	addi	sp,sp,16
    80002380:	8082                	ret

0000000080002382 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80002382:	7135                	addi	sp,sp,-160
    80002384:	ed06                	sd	ra,152(sp)
    80002386:	e922                	sd	s0,144(sp)
    80002388:	e526                	sd	s1,136(sp)
    8000238a:	e14a                	sd	s2,128(sp)
    8000238c:	fcce                	sd	s3,120(sp)
    8000238e:	f8d2                	sd	s4,112(sp)
    80002390:	f4d6                	sd	s5,104(sp)
    80002392:	f0da                	sd	s6,96(sp)
    80002394:	ecde                	sd	s7,88(sp)
    80002396:	e8e2                	sd	s8,80(sp)
    80002398:	e4e6                	sd	s9,72(sp)
    8000239a:	e0ea                	sd	s10,64(sp)
    8000239c:	fc6e                	sd	s11,56(sp)
    8000239e:	1100                	addi	s0,sp,160
    800023a0:	f6a43823          	sd	a0,-144(s0)
    800023a4:	8c2e                	mv	s8,a1
  int id = HASH(blockno);
    800023a6:	4bb5                	li	s7,13
    800023a8:	0375fbbb          	remuw	s7,a1,s7
  acquire(&(bcache.lock[id]));
    800023ac:	005b9c93          	slli	s9,s7,0x5
    800023b0:	0000d497          	auipc	s1,0xd
    800023b4:	e2048493          	addi	s1,s1,-480 # 8000f1d0 <bcache>
    800023b8:	009c87b3          	add	a5,s9,s1
    800023bc:	f6f43023          	sd	a5,-160(s0)
    800023c0:	853e                	mv	a0,a5
    800023c2:	00004097          	auipc	ra,0x4
    800023c6:	29e080e7          	jalr	670(ra) # 80006660 <acquire>
  b = bcache.head[id].next;
    800023ca:	46800793          	li	a5,1128
    800023ce:	02fb87b3          	mul	a5,s7,a5
    800023d2:	00f486b3          	add	a3,s1,a5
    800023d6:	6721                	lui	a4,0x8
    800023d8:	96ba                	add	a3,a3,a4
    800023da:	6286b903          	ld	s2,1576(a3)
  last = &(bcache.head[id]);
    800023de:	5d070a13          	addi	s4,a4,1488 # 85d0 <_entry-0x7fff7a30>
    800023e2:	97d2                	add	a5,a5,s4
    800023e4:	00978a33          	add	s4,a5,s1
  for(; b; b = b->next, last = last->next)
    800023e8:	06090363          	beqz	s2,8000244e <bread+0xcc>
  struct buf *take_buf = 0;
    800023ec:	4481                	li	s1,0
    800023ee:	a0a1                	j	80002436 <bread+0xb4>
    if(b->dev == dev && b->blockno == blockno)
    800023f0:	00c92783          	lw	a5,12(s2)
    800023f4:	05879763          	bne	a5,s8,80002442 <bread+0xc0>
      b->time = ticks;
    800023f8:	00007797          	auipc	a5,0x7
    800023fc:	c207a783          	lw	a5,-992(a5) # 80009018 <ticks>
    80002400:	46f92023          	sw	a5,1120(s2)
      b->refcnt++;
    80002404:	04892783          	lw	a5,72(s2)
    80002408:	2785                	addiw	a5,a5,1
    8000240a:	04f92423          	sw	a5,72(s2)
      release(&(bcache.lock[id]));
    8000240e:	f6043503          	ld	a0,-160(s0)
    80002412:	00004097          	auipc	ra,0x4
    80002416:	31e080e7          	jalr	798(ra) # 80006730 <release>
      acquiresleep(&b->lock);
    8000241a:	01090513          	addi	a0,s2,16
    8000241e:	00001097          	auipc	ra,0x1
    80002422:	5e8080e7          	jalr	1512(ra) # 80003a06 <acquiresleep>
      return b;
    80002426:	84ca                	mv	s1,s2
    80002428:	a255                	j	800025cc <bread+0x24a>
  for(; b; b = b->next, last = last->next)
    8000242a:	05893903          	ld	s2,88(s2)
    8000242e:	058a3a03          	ld	s4,88(s4)
    80002432:	00090d63          	beqz	s2,8000244c <bread+0xca>
    if(b->dev == dev && b->blockno == blockno)
    80002436:	00892783          	lw	a5,8(s2)
    8000243a:	f7043703          	ld	a4,-144(s0)
    8000243e:	fae789e3          	beq	a5,a4,800023f0 <bread+0x6e>
    if(b->refcnt == 0)
    80002442:	04892783          	lw	a5,72(s2)
    80002446:	f3f5                	bnez	a5,8000242a <bread+0xa8>
    80002448:	84ca                	mv	s1,s2
    8000244a:	b7c5                	j	8000242a <bread+0xa8>
  if(take_buf)
    8000244c:	e095                	bnez	s1,80002470 <bread+0xee>
  for(int i = 0; i < NBUCKET; ++i)
    8000244e:	0000dd97          	auipc	s11,0xd
    80002452:	d82d8d93          	addi	s11,s11,-638 # 8000f1d0 <bcache>
    80002456:	00015d17          	auipc	s10,0x15
    8000245a:	34ad0d13          	addi	s10,s10,842 # 800177a0 <bcache+0x85d0>
  uint64 time = __UINT64_MAX__;
    8000245e:	57fd                	li	a5,-1
    80002460:	f8f43023          	sd	a5,-128(s0)
  int lock_num = -1;
    80002464:	597d                	li	s2,-1
  struct buf *last_take = 0;
    80002466:	f8043423          	sd	zero,-120(s0)
    8000246a:	4481                	li	s1,0
  for(int i = 0; i < NBUCKET; ++i)
    8000246c:	4a81                	li	s5,0
    8000246e:	a8c9                	j	80002540 <bread+0x1be>
  take_buf->dev = dev;
    80002470:	f7043783          	ld	a5,-144(s0)
    80002474:	c49c                	sw	a5,8(s1)
  take_buf->blockno = blockno;
    80002476:	0184a623          	sw	s8,12(s1)
  take_buf->valid = 0;
    8000247a:	0004a023          	sw	zero,0(s1)
  take_buf->refcnt = 1;
    8000247e:	4785                	li	a5,1
    80002480:	c4bc                	sw	a5,72(s1)
  take_buf->time = ticks;
    80002482:	00007797          	auipc	a5,0x7
    80002486:	b967a783          	lw	a5,-1130(a5) # 80009018 <ticks>
    8000248a:	46f4a023          	sw	a5,1120(s1)
    release(&(bcache.lock[id]));
    8000248e:	f6043503          	ld	a0,-160(s0)
    80002492:	00004097          	auipc	ra,0x4
    80002496:	29e080e7          	jalr	670(ra) # 80006730 <release>
    acquiresleep(&(take_buf->lock));
    8000249a:	01048513          	addi	a0,s1,16
    8000249e:	00001097          	auipc	ra,0x1
    800024a2:	568080e7          	jalr	1384(ra) # 80003a06 <acquiresleep>
    return take_buf;
    800024a6:	a21d                	j	800025cc <bread+0x24a>
          if(lock_num != -1 && lock_num != i && holding(&(bcache.lock[lock_num])))
    800024a8:	0916                	slli	s2,s2,0x5
    800024aa:	0000d797          	auipc	a5,0xd
    800024ae:	d2678793          	addi	a5,a5,-730 # 8000f1d0 <bcache>
    800024b2:	993e                	add	s2,s2,a5
    800024b4:	854a                	mv	a0,s2
    800024b6:	00004097          	auipc	ra,0x4
    800024ba:	130080e7          	jalr	304(ra) # 800065e6 <holding>
    800024be:	e519                	bnez	a0,800024cc <bread+0x14a>
    800024c0:	f9643423          	sd	s6,-120(s0)
    800024c4:	f7843903          	ld	s2,-136(s0)
    800024c8:	84ce                	mv	s1,s3
    800024ca:	a831                	j	800024e6 <bread+0x164>
            release(&(bcache.lock[lock_num]));
    800024cc:	854a                	mv	a0,s2
    800024ce:	00004097          	auipc	ra,0x4
    800024d2:	262080e7          	jalr	610(ra) # 80006730 <release>
    800024d6:	f9643423          	sd	s6,-120(s0)
    800024da:	f7843903          	ld	s2,-136(s0)
    800024de:	84ce                	mv	s1,s3
    800024e0:	a019                	j	800024e6 <bread+0x164>
    800024e2:	f8043c83          	ld	s9,-128(s0)
    for(b = bcache.head[i].next, tmp = &(bcache.head[i]); b; b = b->next,tmp = tmp->next)
    800024e6:	0589b983          	ld	s3,88(s3)
    800024ea:	058b3b03          	ld	s6,88(s6)
    800024ee:	02098d63          	beqz	s3,80002528 <bread+0x1a6>
    800024f2:	f9943023          	sd	s9,-128(s0)
      if(b->refcnt == 0)
    800024f6:	0489a783          	lw	a5,72(s3)
    800024fa:	f8043703          	ld	a4,-128(s0)
    800024fe:	8cba                	mv	s9,a4
    80002500:	f3fd                	bnez	a5,800024e6 <bread+0x164>
        if(b->time < time)
    80002502:	4609ec83          	lwu	s9,1120(s3)
    80002506:	fcecfee3          	bgeu	s9,a4,800024e2 <bread+0x160>
          if(lock_num != -1 && lock_num != i && holding(&(bcache.lock[lock_num])))
    8000250a:	57fd                	li	a5,-1
    8000250c:	00f90863          	beq	s2,a5,8000251c <bread+0x19a>
    80002510:	f92a9ce3          	bne	s5,s2,800024a8 <bread+0x126>
    80002514:	f9643423          	sd	s6,-120(s0)
    80002518:	84ce                	mv	s1,s3
    8000251a:	b7f1                	j	800024e6 <bread+0x164>
    8000251c:	f9643423          	sd	s6,-120(s0)
    80002520:	f7843903          	ld	s2,-136(s0)
    80002524:	84ce                	mv	s1,s3
    80002526:	b7c1                	j	800024e6 <bread+0x164>
    80002528:	f9943023          	sd	s9,-128(s0)
    if(lock_num != i)
    8000252c:	032a9b63          	bne	s5,s2,80002562 <bread+0x1e0>
  for(int i = 0; i < NBUCKET; ++i)
    80002530:	2a85                	addiw	s5,s5,1
    80002532:	020d8d93          	addi	s11,s11,32
    80002536:	468d0d13          	addi	s10,s10,1128
    8000253a:	47b5                	li	a5,13
    8000253c:	02fa8a63          	beq	s5,a5,80002570 <bread+0x1ee>
    if(i == id) continue;
    80002540:	ff5b88e3          	beq	s7,s5,80002530 <bread+0x1ae>
    acquire(&(bcache.lock[i]));
    80002544:	f7b43423          	sd	s11,-152(s0)
    80002548:	856e                	mv	a0,s11
    8000254a:	00004097          	auipc	ra,0x4
    8000254e:	116080e7          	jalr	278(ra) # 80006660 <acquire>
    for(b = bcache.head[i].next, tmp = &(bcache.head[i]); b; b = b->next,tmp = tmp->next)
    80002552:	8b6a                	mv	s6,s10
    80002554:	058d3983          	ld	s3,88(s10)
    80002558:	fc098ae3          	beqz	s3,8000252c <bread+0x1aa>
    8000255c:	f7543c23          	sd	s5,-136(s0)
    80002560:	bf59                	j	800024f6 <bread+0x174>
      release(&(bcache.lock[i]));
    80002562:	f6843503          	ld	a0,-152(s0)
    80002566:	00004097          	auipc	ra,0x4
    8000256a:	1ca080e7          	jalr	458(ra) # 80006730 <release>
    8000256e:	b7c9                	j	80002530 <bread+0x1ae>
  if (!take_buf) 
    80002570:	c0c1                	beqz	s1,800025f0 <bread+0x26e>
  last_take->next = take_buf->next;
    80002572:	6cbc                	ld	a5,88(s1)
    80002574:	f8843703          	ld	a4,-120(s0)
    80002578:	ef3c                	sd	a5,88(a4)
  take_buf->next = 0;
    8000257a:	0404bc23          	sd	zero,88(s1)
  release(&(bcache.lock[lock_num]));
    8000257e:	0916                	slli	s2,s2,0x5
    80002580:	0000d517          	auipc	a0,0xd
    80002584:	c5050513          	addi	a0,a0,-944 # 8000f1d0 <bcache>
    80002588:	954a                	add	a0,a0,s2
    8000258a:	00004097          	auipc	ra,0x4
    8000258e:	1a6080e7          	jalr	422(ra) # 80006730 <release>
  b->next = take_buf;
    80002592:	049a3c23          	sd	s1,88(s4)
  take_buf->dev = dev;
    80002596:	f7043783          	ld	a5,-144(s0)
    8000259a:	c49c                	sw	a5,8(s1)
  take_buf->blockno = blockno;
    8000259c:	0184a623          	sw	s8,12(s1)
  take_buf->valid = 0;
    800025a0:	0004a023          	sw	zero,0(s1)
  take_buf->refcnt = 1;
    800025a4:	4785                	li	a5,1
    800025a6:	c4bc                	sw	a5,72(s1)
  take_buf->time = ticks;
    800025a8:	00007797          	auipc	a5,0x7
    800025ac:	a707a783          	lw	a5,-1424(a5) # 80009018 <ticks>
    800025b0:	46f4a023          	sw	a5,1120(s1)
  release(&(bcache.lock[id]));
    800025b4:	f6043503          	ld	a0,-160(s0)
    800025b8:	00004097          	auipc	ra,0x4
    800025bc:	178080e7          	jalr	376(ra) # 80006730 <release>
  acquiresleep(&(take_buf->lock));
    800025c0:	01048513          	addi	a0,s1,16
    800025c4:	00001097          	auipc	ra,0x1
    800025c8:	442080e7          	jalr	1090(ra) # 80003a06 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    800025cc:	409c                	lw	a5,0(s1)
    800025ce:	cb8d                	beqz	a5,80002600 <bread+0x27e>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    800025d0:	8526                	mv	a0,s1
    800025d2:	60ea                	ld	ra,152(sp)
    800025d4:	644a                	ld	s0,144(sp)
    800025d6:	64aa                	ld	s1,136(sp)
    800025d8:	690a                	ld	s2,128(sp)
    800025da:	79e6                	ld	s3,120(sp)
    800025dc:	7a46                	ld	s4,112(sp)
    800025de:	7aa6                	ld	s5,104(sp)
    800025e0:	7b06                	ld	s6,96(sp)
    800025e2:	6be6                	ld	s7,88(sp)
    800025e4:	6c46                	ld	s8,80(sp)
    800025e6:	6ca6                	ld	s9,72(sp)
    800025e8:	6d06                	ld	s10,64(sp)
    800025ea:	7de2                	ld	s11,56(sp)
    800025ec:	610d                	addi	sp,sp,160
    800025ee:	8082                	ret
    panic("bget: no buffers");
    800025f0:	00006517          	auipc	a0,0x6
    800025f4:	e9850513          	addi	a0,a0,-360 # 80008488 <syscalls+0xc0>
    800025f8:	00004097          	auipc	ra,0x4
    800025fc:	b34080e7          	jalr	-1228(ra) # 8000612c <panic>
    virtio_disk_rw(b, 0);
    80002600:	4581                	li	a1,0
    80002602:	8526                	mv	a0,s1
    80002604:	00003097          	auipc	ra,0x3
    80002608:	f32080e7          	jalr	-206(ra) # 80005536 <virtio_disk_rw>
    b->valid = 1;
    8000260c:	4785                	li	a5,1
    8000260e:	c09c                	sw	a5,0(s1)
  return b;
    80002610:	b7c1                	j	800025d0 <bread+0x24e>

0000000080002612 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80002612:	1101                	addi	sp,sp,-32
    80002614:	ec06                	sd	ra,24(sp)
    80002616:	e822                	sd	s0,16(sp)
    80002618:	e426                	sd	s1,8(sp)
    8000261a:	1000                	addi	s0,sp,32
    8000261c:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8000261e:	0541                	addi	a0,a0,16
    80002620:	00001097          	auipc	ra,0x1
    80002624:	480080e7          	jalr	1152(ra) # 80003aa0 <holdingsleep>
    80002628:	cd01                	beqz	a0,80002640 <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    8000262a:	4585                	li	a1,1
    8000262c:	8526                	mv	a0,s1
    8000262e:	00003097          	auipc	ra,0x3
    80002632:	f08080e7          	jalr	-248(ra) # 80005536 <virtio_disk_rw>
}
    80002636:	60e2                	ld	ra,24(sp)
    80002638:	6442                	ld	s0,16(sp)
    8000263a:	64a2                	ld	s1,8(sp)
    8000263c:	6105                	addi	sp,sp,32
    8000263e:	8082                	ret
    panic("bwrite");
    80002640:	00006517          	auipc	a0,0x6
    80002644:	e6050513          	addi	a0,a0,-416 # 800084a0 <syscalls+0xd8>
    80002648:	00004097          	auipc	ra,0x4
    8000264c:	ae4080e7          	jalr	-1308(ra) # 8000612c <panic>

0000000080002650 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80002650:	1101                	addi	sp,sp,-32
    80002652:	ec06                	sd	ra,24(sp)
    80002654:	e822                	sd	s0,16(sp)
    80002656:	e426                	sd	s1,8(sp)
    80002658:	e04a                	sd	s2,0(sp)
    8000265a:	1000                	addi	s0,sp,32
    8000265c:	892a                	mv	s2,a0
  if(!holdingsleep(&b->lock))
    8000265e:	01050493          	addi	s1,a0,16
    80002662:	8526                	mv	a0,s1
    80002664:	00001097          	auipc	ra,0x1
    80002668:	43c080e7          	jalr	1084(ra) # 80003aa0 <holdingsleep>
    8000266c:	c531                	beqz	a0,800026b8 <brelse+0x68>
    panic("brelse");

  releasesleep(&b->lock);
    8000266e:	8526                	mv	a0,s1
    80002670:	00001097          	auipc	ra,0x1
    80002674:	3ec080e7          	jalr	1004(ra) # 80003a5c <releasesleep>

  int h = HASH(b->blockno);
    80002678:	00c92483          	lw	s1,12(s2)
  acquire(&bcache.lock[h]);
    8000267c:	47b5                	li	a5,13
    8000267e:	02f4f4bb          	remuw	s1,s1,a5
    80002682:	0496                	slli	s1,s1,0x5
    80002684:	0000d797          	auipc	a5,0xd
    80002688:	b4c78793          	addi	a5,a5,-1204 # 8000f1d0 <bcache>
    8000268c:	94be                	add	s1,s1,a5
    8000268e:	8526                	mv	a0,s1
    80002690:	00004097          	auipc	ra,0x4
    80002694:	fd0080e7          	jalr	-48(ra) # 80006660 <acquire>
  b->refcnt--;
    80002698:	04892783          	lw	a5,72(s2)
    8000269c:	37fd                	addiw	a5,a5,-1
    8000269e:	04f92423          	sw	a5,72(s2)
  release(&bcache.lock[h]);
    800026a2:	8526                	mv	a0,s1
    800026a4:	00004097          	auipc	ra,0x4
    800026a8:	08c080e7          	jalr	140(ra) # 80006730 <release>
}
    800026ac:	60e2                	ld	ra,24(sp)
    800026ae:	6442                	ld	s0,16(sp)
    800026b0:	64a2                	ld	s1,8(sp)
    800026b2:	6902                	ld	s2,0(sp)
    800026b4:	6105                	addi	sp,sp,32
    800026b6:	8082                	ret
    panic("brelse");
    800026b8:	00006517          	auipc	a0,0x6
    800026bc:	df050513          	addi	a0,a0,-528 # 800084a8 <syscalls+0xe0>
    800026c0:	00004097          	auipc	ra,0x4
    800026c4:	a6c080e7          	jalr	-1428(ra) # 8000612c <panic>

00000000800026c8 <bpin>:

void
bpin(struct buf *b) {
    800026c8:	7179                	addi	sp,sp,-48
    800026ca:	f406                	sd	ra,40(sp)
    800026cc:	f022                	sd	s0,32(sp)
    800026ce:	ec26                	sd	s1,24(sp)
    800026d0:	e84a                	sd	s2,16(sp)
    800026d2:	e44e                	sd	s3,8(sp)
    800026d4:	1800                	addi	s0,sp,48
    800026d6:	84aa                	mv	s1,a0
  acquire(&bcache.lock[HASH(b->blockno)]);
    800026d8:	455c                	lw	a5,12(a0)
    800026da:	49b5                	li	s3,13
    800026dc:	0337f7bb          	remuw	a5,a5,s3
    800026e0:	1782                	slli	a5,a5,0x20
    800026e2:	9381                	srli	a5,a5,0x20
    800026e4:	0796                	slli	a5,a5,0x5
    800026e6:	0000d917          	auipc	s2,0xd
    800026ea:	aea90913          	addi	s2,s2,-1302 # 8000f1d0 <bcache>
    800026ee:	00f90533          	add	a0,s2,a5
    800026f2:	00004097          	auipc	ra,0x4
    800026f6:	f6e080e7          	jalr	-146(ra) # 80006660 <acquire>
  b->refcnt++;
    800026fa:	44bc                	lw	a5,72(s1)
    800026fc:	2785                	addiw	a5,a5,1
    800026fe:	c4bc                	sw	a5,72(s1)
  release(&bcache.lock[HASH(b->blockno)]);
    80002700:	44c8                	lw	a0,12(s1)
    80002702:	0335753b          	remuw	a0,a0,s3
    80002706:	1502                	slli	a0,a0,0x20
    80002708:	9101                	srli	a0,a0,0x20
    8000270a:	0516                	slli	a0,a0,0x5
    8000270c:	954a                	add	a0,a0,s2
    8000270e:	00004097          	auipc	ra,0x4
    80002712:	022080e7          	jalr	34(ra) # 80006730 <release>
}
    80002716:	70a2                	ld	ra,40(sp)
    80002718:	7402                	ld	s0,32(sp)
    8000271a:	64e2                	ld	s1,24(sp)
    8000271c:	6942                	ld	s2,16(sp)
    8000271e:	69a2                	ld	s3,8(sp)
    80002720:	6145                	addi	sp,sp,48
    80002722:	8082                	ret

0000000080002724 <bunpin>:

void
bunpin(struct buf *b) {
    80002724:	7179                	addi	sp,sp,-48
    80002726:	f406                	sd	ra,40(sp)
    80002728:	f022                	sd	s0,32(sp)
    8000272a:	ec26                	sd	s1,24(sp)
    8000272c:	e84a                	sd	s2,16(sp)
    8000272e:	e44e                	sd	s3,8(sp)
    80002730:	1800                	addi	s0,sp,48
    80002732:	84aa                	mv	s1,a0
  acquire(&bcache.lock[HASH(b->blockno)]);
    80002734:	455c                	lw	a5,12(a0)
    80002736:	49b5                	li	s3,13
    80002738:	0337f7bb          	remuw	a5,a5,s3
    8000273c:	1782                	slli	a5,a5,0x20
    8000273e:	9381                	srli	a5,a5,0x20
    80002740:	0796                	slli	a5,a5,0x5
    80002742:	0000d917          	auipc	s2,0xd
    80002746:	a8e90913          	addi	s2,s2,-1394 # 8000f1d0 <bcache>
    8000274a:	00f90533          	add	a0,s2,a5
    8000274e:	00004097          	auipc	ra,0x4
    80002752:	f12080e7          	jalr	-238(ra) # 80006660 <acquire>
  b->refcnt--;
    80002756:	44bc                	lw	a5,72(s1)
    80002758:	37fd                	addiw	a5,a5,-1
    8000275a:	c4bc                	sw	a5,72(s1)
  release(&bcache.lock[HASH(b->blockno)]);
    8000275c:	44c8                	lw	a0,12(s1)
    8000275e:	0335753b          	remuw	a0,a0,s3
    80002762:	1502                	slli	a0,a0,0x20
    80002764:	9101                	srli	a0,a0,0x20
    80002766:	0516                	slli	a0,a0,0x5
    80002768:	954a                	add	a0,a0,s2
    8000276a:	00004097          	auipc	ra,0x4
    8000276e:	fc6080e7          	jalr	-58(ra) # 80006730 <release>
    80002772:	70a2                	ld	ra,40(sp)
    80002774:	7402                	ld	s0,32(sp)
    80002776:	64e2                	ld	s1,24(sp)
    80002778:	6942                	ld	s2,16(sp)
    8000277a:	69a2                	ld	s3,8(sp)
    8000277c:	6145                	addi	sp,sp,48
    8000277e:	8082                	ret

0000000080002780 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80002780:	1101                	addi	sp,sp,-32
    80002782:	ec06                	sd	ra,24(sp)
    80002784:	e822                	sd	s0,16(sp)
    80002786:	e426                	sd	s1,8(sp)
    80002788:	e04a                	sd	s2,0(sp)
    8000278a:	1000                	addi	s0,sp,32
    8000278c:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    8000278e:	00d5d59b          	srliw	a1,a1,0xd
    80002792:	00019797          	auipc	a5,0x19
    80002796:	9727a783          	lw	a5,-1678(a5) # 8001b104 <sb+0x1c>
    8000279a:	9dbd                	addw	a1,a1,a5
    8000279c:	00000097          	auipc	ra,0x0
    800027a0:	be6080e7          	jalr	-1050(ra) # 80002382 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    800027a4:	0074f713          	andi	a4,s1,7
    800027a8:	4785                	li	a5,1
    800027aa:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    800027ae:	14ce                	slli	s1,s1,0x33
    800027b0:	90d9                	srli	s1,s1,0x36
    800027b2:	00950733          	add	a4,a0,s1
    800027b6:	06074703          	lbu	a4,96(a4)
    800027ba:	00e7f6b3          	and	a3,a5,a4
    800027be:	c69d                	beqz	a3,800027ec <bfree+0x6c>
    800027c0:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    800027c2:	94aa                	add	s1,s1,a0
    800027c4:	fff7c793          	not	a5,a5
    800027c8:	8ff9                	and	a5,a5,a4
    800027ca:	06f48023          	sb	a5,96(s1)
  log_write(bp);
    800027ce:	00001097          	auipc	ra,0x1
    800027d2:	118080e7          	jalr	280(ra) # 800038e6 <log_write>
  brelse(bp);
    800027d6:	854a                	mv	a0,s2
    800027d8:	00000097          	auipc	ra,0x0
    800027dc:	e78080e7          	jalr	-392(ra) # 80002650 <brelse>
}
    800027e0:	60e2                	ld	ra,24(sp)
    800027e2:	6442                	ld	s0,16(sp)
    800027e4:	64a2                	ld	s1,8(sp)
    800027e6:	6902                	ld	s2,0(sp)
    800027e8:	6105                	addi	sp,sp,32
    800027ea:	8082                	ret
    panic("freeing free block");
    800027ec:	00006517          	auipc	a0,0x6
    800027f0:	cc450513          	addi	a0,a0,-828 # 800084b0 <syscalls+0xe8>
    800027f4:	00004097          	auipc	ra,0x4
    800027f8:	938080e7          	jalr	-1736(ra) # 8000612c <panic>

00000000800027fc <balloc>:
{
    800027fc:	711d                	addi	sp,sp,-96
    800027fe:	ec86                	sd	ra,88(sp)
    80002800:	e8a2                	sd	s0,80(sp)
    80002802:	e4a6                	sd	s1,72(sp)
    80002804:	e0ca                	sd	s2,64(sp)
    80002806:	fc4e                	sd	s3,56(sp)
    80002808:	f852                	sd	s4,48(sp)
    8000280a:	f456                	sd	s5,40(sp)
    8000280c:	f05a                	sd	s6,32(sp)
    8000280e:	ec5e                	sd	s7,24(sp)
    80002810:	e862                	sd	s8,16(sp)
    80002812:	e466                	sd	s9,8(sp)
    80002814:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80002816:	00019797          	auipc	a5,0x19
    8000281a:	8d67a783          	lw	a5,-1834(a5) # 8001b0ec <sb+0x4>
    8000281e:	cbd1                	beqz	a5,800028b2 <balloc+0xb6>
    80002820:	8baa                	mv	s7,a0
    80002822:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80002824:	00019b17          	auipc	s6,0x19
    80002828:	8c4b0b13          	addi	s6,s6,-1852 # 8001b0e8 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000282c:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    8000282e:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002830:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80002832:	6c89                	lui	s9,0x2
    80002834:	a831                	j	80002850 <balloc+0x54>
    brelse(bp);
    80002836:	854a                	mv	a0,s2
    80002838:	00000097          	auipc	ra,0x0
    8000283c:	e18080e7          	jalr	-488(ra) # 80002650 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80002840:	015c87bb          	addw	a5,s9,s5
    80002844:	00078a9b          	sext.w	s5,a5
    80002848:	004b2703          	lw	a4,4(s6)
    8000284c:	06eaf363          	bgeu	s5,a4,800028b2 <balloc+0xb6>
    bp = bread(dev, BBLOCK(b, sb));
    80002850:	41fad79b          	sraiw	a5,s5,0x1f
    80002854:	0137d79b          	srliw	a5,a5,0x13
    80002858:	015787bb          	addw	a5,a5,s5
    8000285c:	40d7d79b          	sraiw	a5,a5,0xd
    80002860:	01cb2583          	lw	a1,28(s6)
    80002864:	9dbd                	addw	a1,a1,a5
    80002866:	855e                	mv	a0,s7
    80002868:	00000097          	auipc	ra,0x0
    8000286c:	b1a080e7          	jalr	-1254(ra) # 80002382 <bread>
    80002870:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002872:	004b2503          	lw	a0,4(s6)
    80002876:	000a849b          	sext.w	s1,s5
    8000287a:	8662                	mv	a2,s8
    8000287c:	faa4fde3          	bgeu	s1,a0,80002836 <balloc+0x3a>
      m = 1 << (bi % 8);
    80002880:	41f6579b          	sraiw	a5,a2,0x1f
    80002884:	01d7d69b          	srliw	a3,a5,0x1d
    80002888:	00c6873b          	addw	a4,a3,a2
    8000288c:	00777793          	andi	a5,a4,7
    80002890:	9f95                	subw	a5,a5,a3
    80002892:	00f997bb          	sllw	a5,s3,a5
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80002896:	4037571b          	sraiw	a4,a4,0x3
    8000289a:	00e906b3          	add	a3,s2,a4
    8000289e:	0606c683          	lbu	a3,96(a3)
    800028a2:	00d7f5b3          	and	a1,a5,a3
    800028a6:	cd91                	beqz	a1,800028c2 <balloc+0xc6>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800028a8:	2605                	addiw	a2,a2,1
    800028aa:	2485                	addiw	s1,s1,1
    800028ac:	fd4618e3          	bne	a2,s4,8000287c <balloc+0x80>
    800028b0:	b759                	j	80002836 <balloc+0x3a>
  panic("balloc: out of blocks");
    800028b2:	00006517          	auipc	a0,0x6
    800028b6:	c1650513          	addi	a0,a0,-1002 # 800084c8 <syscalls+0x100>
    800028ba:	00004097          	auipc	ra,0x4
    800028be:	872080e7          	jalr	-1934(ra) # 8000612c <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
    800028c2:	974a                	add	a4,a4,s2
    800028c4:	8fd5                	or	a5,a5,a3
    800028c6:	06f70023          	sb	a5,96(a4)
        log_write(bp);
    800028ca:	854a                	mv	a0,s2
    800028cc:	00001097          	auipc	ra,0x1
    800028d0:	01a080e7          	jalr	26(ra) # 800038e6 <log_write>
        brelse(bp);
    800028d4:	854a                	mv	a0,s2
    800028d6:	00000097          	auipc	ra,0x0
    800028da:	d7a080e7          	jalr	-646(ra) # 80002650 <brelse>
  bp = bread(dev, bno);
    800028de:	85a6                	mv	a1,s1
    800028e0:	855e                	mv	a0,s7
    800028e2:	00000097          	auipc	ra,0x0
    800028e6:	aa0080e7          	jalr	-1376(ra) # 80002382 <bread>
    800028ea:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    800028ec:	40000613          	li	a2,1024
    800028f0:	4581                	li	a1,0
    800028f2:	06050513          	addi	a0,a0,96
    800028f6:	ffffe097          	auipc	ra,0xffffe
    800028fa:	960080e7          	jalr	-1696(ra) # 80000256 <memset>
  log_write(bp);
    800028fe:	854a                	mv	a0,s2
    80002900:	00001097          	auipc	ra,0x1
    80002904:	fe6080e7          	jalr	-26(ra) # 800038e6 <log_write>
  brelse(bp);
    80002908:	854a                	mv	a0,s2
    8000290a:	00000097          	auipc	ra,0x0
    8000290e:	d46080e7          	jalr	-698(ra) # 80002650 <brelse>
}
    80002912:	8526                	mv	a0,s1
    80002914:	60e6                	ld	ra,88(sp)
    80002916:	6446                	ld	s0,80(sp)
    80002918:	64a6                	ld	s1,72(sp)
    8000291a:	6906                	ld	s2,64(sp)
    8000291c:	79e2                	ld	s3,56(sp)
    8000291e:	7a42                	ld	s4,48(sp)
    80002920:	7aa2                	ld	s5,40(sp)
    80002922:	7b02                	ld	s6,32(sp)
    80002924:	6be2                	ld	s7,24(sp)
    80002926:	6c42                	ld	s8,16(sp)
    80002928:	6ca2                	ld	s9,8(sp)
    8000292a:	6125                	addi	sp,sp,96
    8000292c:	8082                	ret

000000008000292e <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    8000292e:	7179                	addi	sp,sp,-48
    80002930:	f406                	sd	ra,40(sp)
    80002932:	f022                	sd	s0,32(sp)
    80002934:	ec26                	sd	s1,24(sp)
    80002936:	e84a                	sd	s2,16(sp)
    80002938:	e44e                	sd	s3,8(sp)
    8000293a:	e052                	sd	s4,0(sp)
    8000293c:	1800                	addi	s0,sp,48
    8000293e:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80002940:	47ad                	li	a5,11
    80002942:	04b7fe63          	bgeu	a5,a1,8000299e <bmap+0x70>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
    80002946:	ff45849b          	addiw	s1,a1,-12
    8000294a:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    8000294e:	0ff00793          	li	a5,255
    80002952:	0ae7e363          	bltu	a5,a4,800029f8 <bmap+0xca>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    80002956:	08852583          	lw	a1,136(a0)
    8000295a:	c5ad                	beqz	a1,800029c4 <bmap+0x96>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    8000295c:	00092503          	lw	a0,0(s2)
    80002960:	00000097          	auipc	ra,0x0
    80002964:	a22080e7          	jalr	-1502(ra) # 80002382 <bread>
    80002968:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    8000296a:	06050793          	addi	a5,a0,96
    if((addr = a[bn]) == 0){
    8000296e:	02049593          	slli	a1,s1,0x20
    80002972:	9181                	srli	a1,a1,0x20
    80002974:	058a                	slli	a1,a1,0x2
    80002976:	00b784b3          	add	s1,a5,a1
    8000297a:	0004a983          	lw	s3,0(s1)
    8000297e:	04098d63          	beqz	s3,800029d8 <bmap+0xaa>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
    80002982:	8552                	mv	a0,s4
    80002984:	00000097          	auipc	ra,0x0
    80002988:	ccc080e7          	jalr	-820(ra) # 80002650 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    8000298c:	854e                	mv	a0,s3
    8000298e:	70a2                	ld	ra,40(sp)
    80002990:	7402                	ld	s0,32(sp)
    80002992:	64e2                	ld	s1,24(sp)
    80002994:	6942                	ld	s2,16(sp)
    80002996:	69a2                	ld	s3,8(sp)
    80002998:	6a02                	ld	s4,0(sp)
    8000299a:	6145                	addi	sp,sp,48
    8000299c:	8082                	ret
    if((addr = ip->addrs[bn]) == 0)
    8000299e:	02059493          	slli	s1,a1,0x20
    800029a2:	9081                	srli	s1,s1,0x20
    800029a4:	048a                	slli	s1,s1,0x2
    800029a6:	94aa                	add	s1,s1,a0
    800029a8:	0584a983          	lw	s3,88(s1)
    800029ac:	fe0990e3          	bnez	s3,8000298c <bmap+0x5e>
      ip->addrs[bn] = addr = balloc(ip->dev);
    800029b0:	4108                	lw	a0,0(a0)
    800029b2:	00000097          	auipc	ra,0x0
    800029b6:	e4a080e7          	jalr	-438(ra) # 800027fc <balloc>
    800029ba:	0005099b          	sext.w	s3,a0
    800029be:	0534ac23          	sw	s3,88(s1)
    800029c2:	b7e9                	j	8000298c <bmap+0x5e>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    800029c4:	4108                	lw	a0,0(a0)
    800029c6:	00000097          	auipc	ra,0x0
    800029ca:	e36080e7          	jalr	-458(ra) # 800027fc <balloc>
    800029ce:	0005059b          	sext.w	a1,a0
    800029d2:	08b92423          	sw	a1,136(s2)
    800029d6:	b759                	j	8000295c <bmap+0x2e>
      a[bn] = addr = balloc(ip->dev);
    800029d8:	00092503          	lw	a0,0(s2)
    800029dc:	00000097          	auipc	ra,0x0
    800029e0:	e20080e7          	jalr	-480(ra) # 800027fc <balloc>
    800029e4:	0005099b          	sext.w	s3,a0
    800029e8:	0134a023          	sw	s3,0(s1)
      log_write(bp);
    800029ec:	8552                	mv	a0,s4
    800029ee:	00001097          	auipc	ra,0x1
    800029f2:	ef8080e7          	jalr	-264(ra) # 800038e6 <log_write>
    800029f6:	b771                	j	80002982 <bmap+0x54>
  panic("bmap: out of range");
    800029f8:	00006517          	auipc	a0,0x6
    800029fc:	ae850513          	addi	a0,a0,-1304 # 800084e0 <syscalls+0x118>
    80002a00:	00003097          	auipc	ra,0x3
    80002a04:	72c080e7          	jalr	1836(ra) # 8000612c <panic>

0000000080002a08 <iget>:
{
    80002a08:	7179                	addi	sp,sp,-48
    80002a0a:	f406                	sd	ra,40(sp)
    80002a0c:	f022                	sd	s0,32(sp)
    80002a0e:	ec26                	sd	s1,24(sp)
    80002a10:	e84a                	sd	s2,16(sp)
    80002a12:	e44e                	sd	s3,8(sp)
    80002a14:	e052                	sd	s4,0(sp)
    80002a16:	1800                	addi	s0,sp,48
    80002a18:	89aa                	mv	s3,a0
    80002a1a:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    80002a1c:	00018517          	auipc	a0,0x18
    80002a20:	6ec50513          	addi	a0,a0,1772 # 8001b108 <itable>
    80002a24:	00004097          	auipc	ra,0x4
    80002a28:	c3c080e7          	jalr	-964(ra) # 80006660 <acquire>
  empty = 0;
    80002a2c:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002a2e:	00018497          	auipc	s1,0x18
    80002a32:	6fa48493          	addi	s1,s1,1786 # 8001b128 <itable+0x20>
    80002a36:	0001a697          	auipc	a3,0x1a
    80002a3a:	31268693          	addi	a3,a3,786 # 8001cd48 <log>
    80002a3e:	a039                	j	80002a4c <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002a40:	02090b63          	beqz	s2,80002a76 <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002a44:	09048493          	addi	s1,s1,144
    80002a48:	02d48a63          	beq	s1,a3,80002a7c <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80002a4c:	449c                	lw	a5,8(s1)
    80002a4e:	fef059e3          	blez	a5,80002a40 <iget+0x38>
    80002a52:	4098                	lw	a4,0(s1)
    80002a54:	ff3716e3          	bne	a4,s3,80002a40 <iget+0x38>
    80002a58:	40d8                	lw	a4,4(s1)
    80002a5a:	ff4713e3          	bne	a4,s4,80002a40 <iget+0x38>
      ip->ref++;
    80002a5e:	2785                	addiw	a5,a5,1
    80002a60:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80002a62:	00018517          	auipc	a0,0x18
    80002a66:	6a650513          	addi	a0,a0,1702 # 8001b108 <itable>
    80002a6a:	00004097          	auipc	ra,0x4
    80002a6e:	cc6080e7          	jalr	-826(ra) # 80006730 <release>
      return ip;
    80002a72:	8926                	mv	s2,s1
    80002a74:	a03d                	j	80002aa2 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002a76:	f7f9                	bnez	a5,80002a44 <iget+0x3c>
    80002a78:	8926                	mv	s2,s1
    80002a7a:	b7e9                	j	80002a44 <iget+0x3c>
  if(empty == 0)
    80002a7c:	02090c63          	beqz	s2,80002ab4 <iget+0xac>
  ip->dev = dev;
    80002a80:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80002a84:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80002a88:	4785                	li	a5,1
    80002a8a:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80002a8e:	04092423          	sw	zero,72(s2)
  release(&itable.lock);
    80002a92:	00018517          	auipc	a0,0x18
    80002a96:	67650513          	addi	a0,a0,1654 # 8001b108 <itable>
    80002a9a:	00004097          	auipc	ra,0x4
    80002a9e:	c96080e7          	jalr	-874(ra) # 80006730 <release>
}
    80002aa2:	854a                	mv	a0,s2
    80002aa4:	70a2                	ld	ra,40(sp)
    80002aa6:	7402                	ld	s0,32(sp)
    80002aa8:	64e2                	ld	s1,24(sp)
    80002aaa:	6942                	ld	s2,16(sp)
    80002aac:	69a2                	ld	s3,8(sp)
    80002aae:	6a02                	ld	s4,0(sp)
    80002ab0:	6145                	addi	sp,sp,48
    80002ab2:	8082                	ret
    panic("iget: no inodes");
    80002ab4:	00006517          	auipc	a0,0x6
    80002ab8:	a4450513          	addi	a0,a0,-1468 # 800084f8 <syscalls+0x130>
    80002abc:	00003097          	auipc	ra,0x3
    80002ac0:	670080e7          	jalr	1648(ra) # 8000612c <panic>

0000000080002ac4 <fsinit>:
fsinit(int dev) {
    80002ac4:	7179                	addi	sp,sp,-48
    80002ac6:	f406                	sd	ra,40(sp)
    80002ac8:	f022                	sd	s0,32(sp)
    80002aca:	ec26                	sd	s1,24(sp)
    80002acc:	e84a                	sd	s2,16(sp)
    80002ace:	e44e                	sd	s3,8(sp)
    80002ad0:	1800                	addi	s0,sp,48
    80002ad2:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80002ad4:	4585                	li	a1,1
    80002ad6:	00000097          	auipc	ra,0x0
    80002ada:	8ac080e7          	jalr	-1876(ra) # 80002382 <bread>
    80002ade:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80002ae0:	00018997          	auipc	s3,0x18
    80002ae4:	60898993          	addi	s3,s3,1544 # 8001b0e8 <sb>
    80002ae8:	02000613          	li	a2,32
    80002aec:	06050593          	addi	a1,a0,96
    80002af0:	854e                	mv	a0,s3
    80002af2:	ffffd097          	auipc	ra,0xffffd
    80002af6:	7c4080e7          	jalr	1988(ra) # 800002b6 <memmove>
  brelse(bp);
    80002afa:	8526                	mv	a0,s1
    80002afc:	00000097          	auipc	ra,0x0
    80002b00:	b54080e7          	jalr	-1196(ra) # 80002650 <brelse>
  if(sb.magic != FSMAGIC)
    80002b04:	0009a703          	lw	a4,0(s3)
    80002b08:	102037b7          	lui	a5,0x10203
    80002b0c:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002b10:	02f71263          	bne	a4,a5,80002b34 <fsinit+0x70>
  initlog(dev, &sb);
    80002b14:	00018597          	auipc	a1,0x18
    80002b18:	5d458593          	addi	a1,a1,1492 # 8001b0e8 <sb>
    80002b1c:	854a                	mv	a0,s2
    80002b1e:	00001097          	auipc	ra,0x1
    80002b22:	b4c080e7          	jalr	-1204(ra) # 8000366a <initlog>
}
    80002b26:	70a2                	ld	ra,40(sp)
    80002b28:	7402                	ld	s0,32(sp)
    80002b2a:	64e2                	ld	s1,24(sp)
    80002b2c:	6942                	ld	s2,16(sp)
    80002b2e:	69a2                	ld	s3,8(sp)
    80002b30:	6145                	addi	sp,sp,48
    80002b32:	8082                	ret
    panic("invalid file system");
    80002b34:	00006517          	auipc	a0,0x6
    80002b38:	9d450513          	addi	a0,a0,-1580 # 80008508 <syscalls+0x140>
    80002b3c:	00003097          	auipc	ra,0x3
    80002b40:	5f0080e7          	jalr	1520(ra) # 8000612c <panic>

0000000080002b44 <iinit>:
{
    80002b44:	7179                	addi	sp,sp,-48
    80002b46:	f406                	sd	ra,40(sp)
    80002b48:	f022                	sd	s0,32(sp)
    80002b4a:	ec26                	sd	s1,24(sp)
    80002b4c:	e84a                	sd	s2,16(sp)
    80002b4e:	e44e                	sd	s3,8(sp)
    80002b50:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    80002b52:	00006597          	auipc	a1,0x6
    80002b56:	9ce58593          	addi	a1,a1,-1586 # 80008520 <syscalls+0x158>
    80002b5a:	00018517          	auipc	a0,0x18
    80002b5e:	5ae50513          	addi	a0,a0,1454 # 8001b108 <itable>
    80002b62:	00004097          	auipc	ra,0x4
    80002b66:	c7a080e7          	jalr	-902(ra) # 800067dc <initlock>
  for(i = 0; i < NINODE; i++) {
    80002b6a:	00018497          	auipc	s1,0x18
    80002b6e:	5ce48493          	addi	s1,s1,1486 # 8001b138 <itable+0x30>
    80002b72:	0001a997          	auipc	s3,0x1a
    80002b76:	1e698993          	addi	s3,s3,486 # 8001cd58 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80002b7a:	00006917          	auipc	s2,0x6
    80002b7e:	9ae90913          	addi	s2,s2,-1618 # 80008528 <syscalls+0x160>
    80002b82:	85ca                	mv	a1,s2
    80002b84:	8526                	mv	a0,s1
    80002b86:	00001097          	auipc	ra,0x1
    80002b8a:	e46080e7          	jalr	-442(ra) # 800039cc <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80002b8e:	09048493          	addi	s1,s1,144
    80002b92:	ff3498e3          	bne	s1,s3,80002b82 <iinit+0x3e>
}
    80002b96:	70a2                	ld	ra,40(sp)
    80002b98:	7402                	ld	s0,32(sp)
    80002b9a:	64e2                	ld	s1,24(sp)
    80002b9c:	6942                	ld	s2,16(sp)
    80002b9e:	69a2                	ld	s3,8(sp)
    80002ba0:	6145                	addi	sp,sp,48
    80002ba2:	8082                	ret

0000000080002ba4 <ialloc>:
{
    80002ba4:	715d                	addi	sp,sp,-80
    80002ba6:	e486                	sd	ra,72(sp)
    80002ba8:	e0a2                	sd	s0,64(sp)
    80002baa:	fc26                	sd	s1,56(sp)
    80002bac:	f84a                	sd	s2,48(sp)
    80002bae:	f44e                	sd	s3,40(sp)
    80002bb0:	f052                	sd	s4,32(sp)
    80002bb2:	ec56                	sd	s5,24(sp)
    80002bb4:	e85a                	sd	s6,16(sp)
    80002bb6:	e45e                	sd	s7,8(sp)
    80002bb8:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    80002bba:	00018717          	auipc	a4,0x18
    80002bbe:	53a72703          	lw	a4,1338(a4) # 8001b0f4 <sb+0xc>
    80002bc2:	4785                	li	a5,1
    80002bc4:	04e7fa63          	bgeu	a5,a4,80002c18 <ialloc+0x74>
    80002bc8:	8aaa                	mv	s5,a0
    80002bca:	8bae                	mv	s7,a1
    80002bcc:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    80002bce:	00018a17          	auipc	s4,0x18
    80002bd2:	51aa0a13          	addi	s4,s4,1306 # 8001b0e8 <sb>
    80002bd6:	00048b1b          	sext.w	s6,s1
    80002bda:	0044d593          	srli	a1,s1,0x4
    80002bde:	018a2783          	lw	a5,24(s4)
    80002be2:	9dbd                	addw	a1,a1,a5
    80002be4:	8556                	mv	a0,s5
    80002be6:	fffff097          	auipc	ra,0xfffff
    80002bea:	79c080e7          	jalr	1948(ra) # 80002382 <bread>
    80002bee:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002bf0:	06050993          	addi	s3,a0,96
    80002bf4:	00f4f793          	andi	a5,s1,15
    80002bf8:	079a                	slli	a5,a5,0x6
    80002bfa:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80002bfc:	00099783          	lh	a5,0(s3)
    80002c00:	c785                	beqz	a5,80002c28 <ialloc+0x84>
    brelse(bp);
    80002c02:	00000097          	auipc	ra,0x0
    80002c06:	a4e080e7          	jalr	-1458(ra) # 80002650 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80002c0a:	0485                	addi	s1,s1,1
    80002c0c:	00ca2703          	lw	a4,12(s4)
    80002c10:	0004879b          	sext.w	a5,s1
    80002c14:	fce7e1e3          	bltu	a5,a4,80002bd6 <ialloc+0x32>
  panic("ialloc: no inodes");
    80002c18:	00006517          	auipc	a0,0x6
    80002c1c:	91850513          	addi	a0,a0,-1768 # 80008530 <syscalls+0x168>
    80002c20:	00003097          	auipc	ra,0x3
    80002c24:	50c080e7          	jalr	1292(ra) # 8000612c <panic>
      memset(dip, 0, sizeof(*dip));
    80002c28:	04000613          	li	a2,64
    80002c2c:	4581                	li	a1,0
    80002c2e:	854e                	mv	a0,s3
    80002c30:	ffffd097          	auipc	ra,0xffffd
    80002c34:	626080e7          	jalr	1574(ra) # 80000256 <memset>
      dip->type = type;
    80002c38:	01799023          	sh	s7,0(s3)
      log_write(bp);   // mark it allocated on the disk
    80002c3c:	854a                	mv	a0,s2
    80002c3e:	00001097          	auipc	ra,0x1
    80002c42:	ca8080e7          	jalr	-856(ra) # 800038e6 <log_write>
      brelse(bp);
    80002c46:	854a                	mv	a0,s2
    80002c48:	00000097          	auipc	ra,0x0
    80002c4c:	a08080e7          	jalr	-1528(ra) # 80002650 <brelse>
      return iget(dev, inum);
    80002c50:	85da                	mv	a1,s6
    80002c52:	8556                	mv	a0,s5
    80002c54:	00000097          	auipc	ra,0x0
    80002c58:	db4080e7          	jalr	-588(ra) # 80002a08 <iget>
}
    80002c5c:	60a6                	ld	ra,72(sp)
    80002c5e:	6406                	ld	s0,64(sp)
    80002c60:	74e2                	ld	s1,56(sp)
    80002c62:	7942                	ld	s2,48(sp)
    80002c64:	79a2                	ld	s3,40(sp)
    80002c66:	7a02                	ld	s4,32(sp)
    80002c68:	6ae2                	ld	s5,24(sp)
    80002c6a:	6b42                	ld	s6,16(sp)
    80002c6c:	6ba2                	ld	s7,8(sp)
    80002c6e:	6161                	addi	sp,sp,80
    80002c70:	8082                	ret

0000000080002c72 <iupdate>:
{
    80002c72:	1101                	addi	sp,sp,-32
    80002c74:	ec06                	sd	ra,24(sp)
    80002c76:	e822                	sd	s0,16(sp)
    80002c78:	e426                	sd	s1,8(sp)
    80002c7a:	e04a                	sd	s2,0(sp)
    80002c7c:	1000                	addi	s0,sp,32
    80002c7e:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002c80:	415c                	lw	a5,4(a0)
    80002c82:	0047d79b          	srliw	a5,a5,0x4
    80002c86:	00018597          	auipc	a1,0x18
    80002c8a:	47a5a583          	lw	a1,1146(a1) # 8001b100 <sb+0x18>
    80002c8e:	9dbd                	addw	a1,a1,a5
    80002c90:	4108                	lw	a0,0(a0)
    80002c92:	fffff097          	auipc	ra,0xfffff
    80002c96:	6f0080e7          	jalr	1776(ra) # 80002382 <bread>
    80002c9a:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002c9c:	06050793          	addi	a5,a0,96
    80002ca0:	40c8                	lw	a0,4(s1)
    80002ca2:	893d                	andi	a0,a0,15
    80002ca4:	051a                	slli	a0,a0,0x6
    80002ca6:	953e                	add	a0,a0,a5
  dip->type = ip->type;
    80002ca8:	04c49703          	lh	a4,76(s1)
    80002cac:	00e51023          	sh	a4,0(a0)
  dip->major = ip->major;
    80002cb0:	04e49703          	lh	a4,78(s1)
    80002cb4:	00e51123          	sh	a4,2(a0)
  dip->minor = ip->minor;
    80002cb8:	05049703          	lh	a4,80(s1)
    80002cbc:	00e51223          	sh	a4,4(a0)
  dip->nlink = ip->nlink;
    80002cc0:	05249703          	lh	a4,82(s1)
    80002cc4:	00e51323          	sh	a4,6(a0)
  dip->size = ip->size;
    80002cc8:	48f8                	lw	a4,84(s1)
    80002cca:	c518                	sw	a4,8(a0)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002ccc:	03400613          	li	a2,52
    80002cd0:	05848593          	addi	a1,s1,88
    80002cd4:	0531                	addi	a0,a0,12
    80002cd6:	ffffd097          	auipc	ra,0xffffd
    80002cda:	5e0080e7          	jalr	1504(ra) # 800002b6 <memmove>
  log_write(bp);
    80002cde:	854a                	mv	a0,s2
    80002ce0:	00001097          	auipc	ra,0x1
    80002ce4:	c06080e7          	jalr	-1018(ra) # 800038e6 <log_write>
  brelse(bp);
    80002ce8:	854a                	mv	a0,s2
    80002cea:	00000097          	auipc	ra,0x0
    80002cee:	966080e7          	jalr	-1690(ra) # 80002650 <brelse>
}
    80002cf2:	60e2                	ld	ra,24(sp)
    80002cf4:	6442                	ld	s0,16(sp)
    80002cf6:	64a2                	ld	s1,8(sp)
    80002cf8:	6902                	ld	s2,0(sp)
    80002cfa:	6105                	addi	sp,sp,32
    80002cfc:	8082                	ret

0000000080002cfe <idup>:
{
    80002cfe:	1101                	addi	sp,sp,-32
    80002d00:	ec06                	sd	ra,24(sp)
    80002d02:	e822                	sd	s0,16(sp)
    80002d04:	e426                	sd	s1,8(sp)
    80002d06:	1000                	addi	s0,sp,32
    80002d08:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002d0a:	00018517          	auipc	a0,0x18
    80002d0e:	3fe50513          	addi	a0,a0,1022 # 8001b108 <itable>
    80002d12:	00004097          	auipc	ra,0x4
    80002d16:	94e080e7          	jalr	-1714(ra) # 80006660 <acquire>
  ip->ref++;
    80002d1a:	449c                	lw	a5,8(s1)
    80002d1c:	2785                	addiw	a5,a5,1
    80002d1e:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002d20:	00018517          	auipc	a0,0x18
    80002d24:	3e850513          	addi	a0,a0,1000 # 8001b108 <itable>
    80002d28:	00004097          	auipc	ra,0x4
    80002d2c:	a08080e7          	jalr	-1528(ra) # 80006730 <release>
}
    80002d30:	8526                	mv	a0,s1
    80002d32:	60e2                	ld	ra,24(sp)
    80002d34:	6442                	ld	s0,16(sp)
    80002d36:	64a2                	ld	s1,8(sp)
    80002d38:	6105                	addi	sp,sp,32
    80002d3a:	8082                	ret

0000000080002d3c <ilock>:
{
    80002d3c:	1101                	addi	sp,sp,-32
    80002d3e:	ec06                	sd	ra,24(sp)
    80002d40:	e822                	sd	s0,16(sp)
    80002d42:	e426                	sd	s1,8(sp)
    80002d44:	e04a                	sd	s2,0(sp)
    80002d46:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80002d48:	c115                	beqz	a0,80002d6c <ilock+0x30>
    80002d4a:	84aa                	mv	s1,a0
    80002d4c:	451c                	lw	a5,8(a0)
    80002d4e:	00f05f63          	blez	a5,80002d6c <ilock+0x30>
  acquiresleep(&ip->lock);
    80002d52:	0541                	addi	a0,a0,16
    80002d54:	00001097          	auipc	ra,0x1
    80002d58:	cb2080e7          	jalr	-846(ra) # 80003a06 <acquiresleep>
  if(ip->valid == 0){
    80002d5c:	44bc                	lw	a5,72(s1)
    80002d5e:	cf99                	beqz	a5,80002d7c <ilock+0x40>
}
    80002d60:	60e2                	ld	ra,24(sp)
    80002d62:	6442                	ld	s0,16(sp)
    80002d64:	64a2                	ld	s1,8(sp)
    80002d66:	6902                	ld	s2,0(sp)
    80002d68:	6105                	addi	sp,sp,32
    80002d6a:	8082                	ret
    panic("ilock");
    80002d6c:	00005517          	auipc	a0,0x5
    80002d70:	7dc50513          	addi	a0,a0,2012 # 80008548 <syscalls+0x180>
    80002d74:	00003097          	auipc	ra,0x3
    80002d78:	3b8080e7          	jalr	952(ra) # 8000612c <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002d7c:	40dc                	lw	a5,4(s1)
    80002d7e:	0047d79b          	srliw	a5,a5,0x4
    80002d82:	00018597          	auipc	a1,0x18
    80002d86:	37e5a583          	lw	a1,894(a1) # 8001b100 <sb+0x18>
    80002d8a:	9dbd                	addw	a1,a1,a5
    80002d8c:	4088                	lw	a0,0(s1)
    80002d8e:	fffff097          	auipc	ra,0xfffff
    80002d92:	5f4080e7          	jalr	1524(ra) # 80002382 <bread>
    80002d96:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002d98:	06050593          	addi	a1,a0,96
    80002d9c:	40dc                	lw	a5,4(s1)
    80002d9e:	8bbd                	andi	a5,a5,15
    80002da0:	079a                	slli	a5,a5,0x6
    80002da2:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002da4:	00059783          	lh	a5,0(a1)
    80002da8:	04f49623          	sh	a5,76(s1)
    ip->major = dip->major;
    80002dac:	00259783          	lh	a5,2(a1)
    80002db0:	04f49723          	sh	a5,78(s1)
    ip->minor = dip->minor;
    80002db4:	00459783          	lh	a5,4(a1)
    80002db8:	04f49823          	sh	a5,80(s1)
    ip->nlink = dip->nlink;
    80002dbc:	00659783          	lh	a5,6(a1)
    80002dc0:	04f49923          	sh	a5,82(s1)
    ip->size = dip->size;
    80002dc4:	459c                	lw	a5,8(a1)
    80002dc6:	c8fc                	sw	a5,84(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002dc8:	03400613          	li	a2,52
    80002dcc:	05b1                	addi	a1,a1,12
    80002dce:	05848513          	addi	a0,s1,88
    80002dd2:	ffffd097          	auipc	ra,0xffffd
    80002dd6:	4e4080e7          	jalr	1252(ra) # 800002b6 <memmove>
    brelse(bp);
    80002dda:	854a                	mv	a0,s2
    80002ddc:	00000097          	auipc	ra,0x0
    80002de0:	874080e7          	jalr	-1932(ra) # 80002650 <brelse>
    ip->valid = 1;
    80002de4:	4785                	li	a5,1
    80002de6:	c4bc                	sw	a5,72(s1)
    if(ip->type == 0)
    80002de8:	04c49783          	lh	a5,76(s1)
    80002dec:	fbb5                	bnez	a5,80002d60 <ilock+0x24>
      panic("ilock: no type");
    80002dee:	00005517          	auipc	a0,0x5
    80002df2:	76250513          	addi	a0,a0,1890 # 80008550 <syscalls+0x188>
    80002df6:	00003097          	auipc	ra,0x3
    80002dfa:	336080e7          	jalr	822(ra) # 8000612c <panic>

0000000080002dfe <iunlock>:
{
    80002dfe:	1101                	addi	sp,sp,-32
    80002e00:	ec06                	sd	ra,24(sp)
    80002e02:	e822                	sd	s0,16(sp)
    80002e04:	e426                	sd	s1,8(sp)
    80002e06:	e04a                	sd	s2,0(sp)
    80002e08:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80002e0a:	c905                	beqz	a0,80002e3a <iunlock+0x3c>
    80002e0c:	84aa                	mv	s1,a0
    80002e0e:	01050913          	addi	s2,a0,16
    80002e12:	854a                	mv	a0,s2
    80002e14:	00001097          	auipc	ra,0x1
    80002e18:	c8c080e7          	jalr	-884(ra) # 80003aa0 <holdingsleep>
    80002e1c:	cd19                	beqz	a0,80002e3a <iunlock+0x3c>
    80002e1e:	449c                	lw	a5,8(s1)
    80002e20:	00f05d63          	blez	a5,80002e3a <iunlock+0x3c>
  releasesleep(&ip->lock);
    80002e24:	854a                	mv	a0,s2
    80002e26:	00001097          	auipc	ra,0x1
    80002e2a:	c36080e7          	jalr	-970(ra) # 80003a5c <releasesleep>
}
    80002e2e:	60e2                	ld	ra,24(sp)
    80002e30:	6442                	ld	s0,16(sp)
    80002e32:	64a2                	ld	s1,8(sp)
    80002e34:	6902                	ld	s2,0(sp)
    80002e36:	6105                	addi	sp,sp,32
    80002e38:	8082                	ret
    panic("iunlock");
    80002e3a:	00005517          	auipc	a0,0x5
    80002e3e:	72650513          	addi	a0,a0,1830 # 80008560 <syscalls+0x198>
    80002e42:	00003097          	auipc	ra,0x3
    80002e46:	2ea080e7          	jalr	746(ra) # 8000612c <panic>

0000000080002e4a <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002e4a:	7179                	addi	sp,sp,-48
    80002e4c:	f406                	sd	ra,40(sp)
    80002e4e:	f022                	sd	s0,32(sp)
    80002e50:	ec26                	sd	s1,24(sp)
    80002e52:	e84a                	sd	s2,16(sp)
    80002e54:	e44e                	sd	s3,8(sp)
    80002e56:	e052                	sd	s4,0(sp)
    80002e58:	1800                	addi	s0,sp,48
    80002e5a:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002e5c:	05850493          	addi	s1,a0,88
    80002e60:	08850913          	addi	s2,a0,136
    80002e64:	a021                	j	80002e6c <itrunc+0x22>
    80002e66:	0491                	addi	s1,s1,4
    80002e68:	01248d63          	beq	s1,s2,80002e82 <itrunc+0x38>
    if(ip->addrs[i]){
    80002e6c:	408c                	lw	a1,0(s1)
    80002e6e:	dde5                	beqz	a1,80002e66 <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    80002e70:	0009a503          	lw	a0,0(s3)
    80002e74:	00000097          	auipc	ra,0x0
    80002e78:	90c080e7          	jalr	-1780(ra) # 80002780 <bfree>
      ip->addrs[i] = 0;
    80002e7c:	0004a023          	sw	zero,0(s1)
    80002e80:	b7dd                	j	80002e66 <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    80002e82:	0889a583          	lw	a1,136(s3)
    80002e86:	e185                	bnez	a1,80002ea6 <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80002e88:	0409aa23          	sw	zero,84(s3)
  iupdate(ip);
    80002e8c:	854e                	mv	a0,s3
    80002e8e:	00000097          	auipc	ra,0x0
    80002e92:	de4080e7          	jalr	-540(ra) # 80002c72 <iupdate>
}
    80002e96:	70a2                	ld	ra,40(sp)
    80002e98:	7402                	ld	s0,32(sp)
    80002e9a:	64e2                	ld	s1,24(sp)
    80002e9c:	6942                	ld	s2,16(sp)
    80002e9e:	69a2                	ld	s3,8(sp)
    80002ea0:	6a02                	ld	s4,0(sp)
    80002ea2:	6145                	addi	sp,sp,48
    80002ea4:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002ea6:	0009a503          	lw	a0,0(s3)
    80002eaa:	fffff097          	auipc	ra,0xfffff
    80002eae:	4d8080e7          	jalr	1240(ra) # 80002382 <bread>
    80002eb2:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80002eb4:	06050493          	addi	s1,a0,96
    80002eb8:	46050913          	addi	s2,a0,1120
    80002ebc:	a811                	j	80002ed0 <itrunc+0x86>
        bfree(ip->dev, a[j]);
    80002ebe:	0009a503          	lw	a0,0(s3)
    80002ec2:	00000097          	auipc	ra,0x0
    80002ec6:	8be080e7          	jalr	-1858(ra) # 80002780 <bfree>
    for(j = 0; j < NINDIRECT; j++){
    80002eca:	0491                	addi	s1,s1,4
    80002ecc:	01248563          	beq	s1,s2,80002ed6 <itrunc+0x8c>
      if(a[j])
    80002ed0:	408c                	lw	a1,0(s1)
    80002ed2:	dde5                	beqz	a1,80002eca <itrunc+0x80>
    80002ed4:	b7ed                	j	80002ebe <itrunc+0x74>
    brelse(bp);
    80002ed6:	8552                	mv	a0,s4
    80002ed8:	fffff097          	auipc	ra,0xfffff
    80002edc:	778080e7          	jalr	1912(ra) # 80002650 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80002ee0:	0889a583          	lw	a1,136(s3)
    80002ee4:	0009a503          	lw	a0,0(s3)
    80002ee8:	00000097          	auipc	ra,0x0
    80002eec:	898080e7          	jalr	-1896(ra) # 80002780 <bfree>
    ip->addrs[NDIRECT] = 0;
    80002ef0:	0809a423          	sw	zero,136(s3)
    80002ef4:	bf51                	j	80002e88 <itrunc+0x3e>

0000000080002ef6 <iput>:
{
    80002ef6:	1101                	addi	sp,sp,-32
    80002ef8:	ec06                	sd	ra,24(sp)
    80002efa:	e822                	sd	s0,16(sp)
    80002efc:	e426                	sd	s1,8(sp)
    80002efe:	e04a                	sd	s2,0(sp)
    80002f00:	1000                	addi	s0,sp,32
    80002f02:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002f04:	00018517          	auipc	a0,0x18
    80002f08:	20450513          	addi	a0,a0,516 # 8001b108 <itable>
    80002f0c:	00003097          	auipc	ra,0x3
    80002f10:	754080e7          	jalr	1876(ra) # 80006660 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002f14:	4498                	lw	a4,8(s1)
    80002f16:	4785                	li	a5,1
    80002f18:	02f70363          	beq	a4,a5,80002f3e <iput+0x48>
  ip->ref--;
    80002f1c:	449c                	lw	a5,8(s1)
    80002f1e:	37fd                	addiw	a5,a5,-1
    80002f20:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002f22:	00018517          	auipc	a0,0x18
    80002f26:	1e650513          	addi	a0,a0,486 # 8001b108 <itable>
    80002f2a:	00004097          	auipc	ra,0x4
    80002f2e:	806080e7          	jalr	-2042(ra) # 80006730 <release>
}
    80002f32:	60e2                	ld	ra,24(sp)
    80002f34:	6442                	ld	s0,16(sp)
    80002f36:	64a2                	ld	s1,8(sp)
    80002f38:	6902                	ld	s2,0(sp)
    80002f3a:	6105                	addi	sp,sp,32
    80002f3c:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002f3e:	44bc                	lw	a5,72(s1)
    80002f40:	dff1                	beqz	a5,80002f1c <iput+0x26>
    80002f42:	05249783          	lh	a5,82(s1)
    80002f46:	fbf9                	bnez	a5,80002f1c <iput+0x26>
    acquiresleep(&ip->lock);
    80002f48:	01048913          	addi	s2,s1,16
    80002f4c:	854a                	mv	a0,s2
    80002f4e:	00001097          	auipc	ra,0x1
    80002f52:	ab8080e7          	jalr	-1352(ra) # 80003a06 <acquiresleep>
    release(&itable.lock);
    80002f56:	00018517          	auipc	a0,0x18
    80002f5a:	1b250513          	addi	a0,a0,434 # 8001b108 <itable>
    80002f5e:	00003097          	auipc	ra,0x3
    80002f62:	7d2080e7          	jalr	2002(ra) # 80006730 <release>
    itrunc(ip);
    80002f66:	8526                	mv	a0,s1
    80002f68:	00000097          	auipc	ra,0x0
    80002f6c:	ee2080e7          	jalr	-286(ra) # 80002e4a <itrunc>
    ip->type = 0;
    80002f70:	04049623          	sh	zero,76(s1)
    iupdate(ip);
    80002f74:	8526                	mv	a0,s1
    80002f76:	00000097          	auipc	ra,0x0
    80002f7a:	cfc080e7          	jalr	-772(ra) # 80002c72 <iupdate>
    ip->valid = 0;
    80002f7e:	0404a423          	sw	zero,72(s1)
    releasesleep(&ip->lock);
    80002f82:	854a                	mv	a0,s2
    80002f84:	00001097          	auipc	ra,0x1
    80002f88:	ad8080e7          	jalr	-1320(ra) # 80003a5c <releasesleep>
    acquire(&itable.lock);
    80002f8c:	00018517          	auipc	a0,0x18
    80002f90:	17c50513          	addi	a0,a0,380 # 8001b108 <itable>
    80002f94:	00003097          	auipc	ra,0x3
    80002f98:	6cc080e7          	jalr	1740(ra) # 80006660 <acquire>
    80002f9c:	b741                	j	80002f1c <iput+0x26>

0000000080002f9e <iunlockput>:
{
    80002f9e:	1101                	addi	sp,sp,-32
    80002fa0:	ec06                	sd	ra,24(sp)
    80002fa2:	e822                	sd	s0,16(sp)
    80002fa4:	e426                	sd	s1,8(sp)
    80002fa6:	1000                	addi	s0,sp,32
    80002fa8:	84aa                	mv	s1,a0
  iunlock(ip);
    80002faa:	00000097          	auipc	ra,0x0
    80002fae:	e54080e7          	jalr	-428(ra) # 80002dfe <iunlock>
  iput(ip);
    80002fb2:	8526                	mv	a0,s1
    80002fb4:	00000097          	auipc	ra,0x0
    80002fb8:	f42080e7          	jalr	-190(ra) # 80002ef6 <iput>
}
    80002fbc:	60e2                	ld	ra,24(sp)
    80002fbe:	6442                	ld	s0,16(sp)
    80002fc0:	64a2                	ld	s1,8(sp)
    80002fc2:	6105                	addi	sp,sp,32
    80002fc4:	8082                	ret

0000000080002fc6 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80002fc6:	1141                	addi	sp,sp,-16
    80002fc8:	e422                	sd	s0,8(sp)
    80002fca:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80002fcc:	411c                	lw	a5,0(a0)
    80002fce:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80002fd0:	415c                	lw	a5,4(a0)
    80002fd2:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80002fd4:	04c51783          	lh	a5,76(a0)
    80002fd8:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80002fdc:	05251783          	lh	a5,82(a0)
    80002fe0:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80002fe4:	05456783          	lwu	a5,84(a0)
    80002fe8:	e99c                	sd	a5,16(a1)
}
    80002fea:	6422                	ld	s0,8(sp)
    80002fec:	0141                	addi	sp,sp,16
    80002fee:	8082                	ret

0000000080002ff0 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002ff0:	497c                	lw	a5,84(a0)
    80002ff2:	0ed7e963          	bltu	a5,a3,800030e4 <readi+0xf4>
{
    80002ff6:	7159                	addi	sp,sp,-112
    80002ff8:	f486                	sd	ra,104(sp)
    80002ffa:	f0a2                	sd	s0,96(sp)
    80002ffc:	eca6                	sd	s1,88(sp)
    80002ffe:	e8ca                	sd	s2,80(sp)
    80003000:	e4ce                	sd	s3,72(sp)
    80003002:	e0d2                	sd	s4,64(sp)
    80003004:	fc56                	sd	s5,56(sp)
    80003006:	f85a                	sd	s6,48(sp)
    80003008:	f45e                	sd	s7,40(sp)
    8000300a:	f062                	sd	s8,32(sp)
    8000300c:	ec66                	sd	s9,24(sp)
    8000300e:	e86a                	sd	s10,16(sp)
    80003010:	e46e                	sd	s11,8(sp)
    80003012:	1880                	addi	s0,sp,112
    80003014:	8baa                	mv	s7,a0
    80003016:	8c2e                	mv	s8,a1
    80003018:	8ab2                	mv	s5,a2
    8000301a:	84b6                	mv	s1,a3
    8000301c:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    8000301e:	9f35                	addw	a4,a4,a3
    return 0;
    80003020:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80003022:	0ad76063          	bltu	a4,a3,800030c2 <readi+0xd2>
  if(off + n > ip->size)
    80003026:	00e7f463          	bgeu	a5,a4,8000302e <readi+0x3e>
    n = ip->size - off;
    8000302a:	40d78b3b          	subw	s6,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    8000302e:	0a0b0963          	beqz	s6,800030e0 <readi+0xf0>
    80003032:	4981                	li	s3,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80003034:	40000d13          	li	s10,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80003038:	5cfd                	li	s9,-1
    8000303a:	a82d                	j	80003074 <readi+0x84>
    8000303c:	020a1d93          	slli	s11,s4,0x20
    80003040:	020ddd93          	srli	s11,s11,0x20
    80003044:	06090613          	addi	a2,s2,96
    80003048:	86ee                	mv	a3,s11
    8000304a:	963a                	add	a2,a2,a4
    8000304c:	85d6                	mv	a1,s5
    8000304e:	8562                	mv	a0,s8
    80003050:	fffff097          	auipc	ra,0xfffff
    80003054:	946080e7          	jalr	-1722(ra) # 80001996 <either_copyout>
    80003058:	05950d63          	beq	a0,s9,800030b2 <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    8000305c:	854a                	mv	a0,s2
    8000305e:	fffff097          	auipc	ra,0xfffff
    80003062:	5f2080e7          	jalr	1522(ra) # 80002650 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003066:	013a09bb          	addw	s3,s4,s3
    8000306a:	009a04bb          	addw	s1,s4,s1
    8000306e:	9aee                	add	s5,s5,s11
    80003070:	0569f763          	bgeu	s3,s6,800030be <readi+0xce>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80003074:	000ba903          	lw	s2,0(s7)
    80003078:	00a4d59b          	srliw	a1,s1,0xa
    8000307c:	855e                	mv	a0,s7
    8000307e:	00000097          	auipc	ra,0x0
    80003082:	8b0080e7          	jalr	-1872(ra) # 8000292e <bmap>
    80003086:	0005059b          	sext.w	a1,a0
    8000308a:	854a                	mv	a0,s2
    8000308c:	fffff097          	auipc	ra,0xfffff
    80003090:	2f6080e7          	jalr	758(ra) # 80002382 <bread>
    80003094:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003096:	3ff4f713          	andi	a4,s1,1023
    8000309a:	40ed07bb          	subw	a5,s10,a4
    8000309e:	413b06bb          	subw	a3,s6,s3
    800030a2:	8a3e                	mv	s4,a5
    800030a4:	2781                	sext.w	a5,a5
    800030a6:	0006861b          	sext.w	a2,a3
    800030aa:	f8f679e3          	bgeu	a2,a5,8000303c <readi+0x4c>
    800030ae:	8a36                	mv	s4,a3
    800030b0:	b771                	j	8000303c <readi+0x4c>
      brelse(bp);
    800030b2:	854a                	mv	a0,s2
    800030b4:	fffff097          	auipc	ra,0xfffff
    800030b8:	59c080e7          	jalr	1436(ra) # 80002650 <brelse>
      tot = -1;
    800030bc:	59fd                	li	s3,-1
  }
  return tot;
    800030be:	0009851b          	sext.w	a0,s3
}
    800030c2:	70a6                	ld	ra,104(sp)
    800030c4:	7406                	ld	s0,96(sp)
    800030c6:	64e6                	ld	s1,88(sp)
    800030c8:	6946                	ld	s2,80(sp)
    800030ca:	69a6                	ld	s3,72(sp)
    800030cc:	6a06                	ld	s4,64(sp)
    800030ce:	7ae2                	ld	s5,56(sp)
    800030d0:	7b42                	ld	s6,48(sp)
    800030d2:	7ba2                	ld	s7,40(sp)
    800030d4:	7c02                	ld	s8,32(sp)
    800030d6:	6ce2                	ld	s9,24(sp)
    800030d8:	6d42                	ld	s10,16(sp)
    800030da:	6da2                	ld	s11,8(sp)
    800030dc:	6165                	addi	sp,sp,112
    800030de:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800030e0:	89da                	mv	s3,s6
    800030e2:	bff1                	j	800030be <readi+0xce>
    return 0;
    800030e4:	4501                	li	a0,0
}
    800030e6:	8082                	ret

00000000800030e8 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800030e8:	497c                	lw	a5,84(a0)
    800030ea:	10d7e863          	bltu	a5,a3,800031fa <writei+0x112>
{
    800030ee:	7159                	addi	sp,sp,-112
    800030f0:	f486                	sd	ra,104(sp)
    800030f2:	f0a2                	sd	s0,96(sp)
    800030f4:	eca6                	sd	s1,88(sp)
    800030f6:	e8ca                	sd	s2,80(sp)
    800030f8:	e4ce                	sd	s3,72(sp)
    800030fa:	e0d2                	sd	s4,64(sp)
    800030fc:	fc56                	sd	s5,56(sp)
    800030fe:	f85a                	sd	s6,48(sp)
    80003100:	f45e                	sd	s7,40(sp)
    80003102:	f062                	sd	s8,32(sp)
    80003104:	ec66                	sd	s9,24(sp)
    80003106:	e86a                	sd	s10,16(sp)
    80003108:	e46e                	sd	s11,8(sp)
    8000310a:	1880                	addi	s0,sp,112
    8000310c:	8b2a                	mv	s6,a0
    8000310e:	8c2e                	mv	s8,a1
    80003110:	8ab2                	mv	s5,a2
    80003112:	8936                	mv	s2,a3
    80003114:	8bba                	mv	s7,a4
  if(off > ip->size || off + n < off)
    80003116:	00e687bb          	addw	a5,a3,a4
    8000311a:	0ed7e263          	bltu	a5,a3,800031fe <writei+0x116>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    8000311e:	00043737          	lui	a4,0x43
    80003122:	0ef76063          	bltu	a4,a5,80003202 <writei+0x11a>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003126:	0c0b8863          	beqz	s7,800031f6 <writei+0x10e>
    8000312a:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    8000312c:	40000d13          	li	s10,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80003130:	5cfd                	li	s9,-1
    80003132:	a091                	j	80003176 <writei+0x8e>
    80003134:	02099d93          	slli	s11,s3,0x20
    80003138:	020ddd93          	srli	s11,s11,0x20
    8000313c:	06048513          	addi	a0,s1,96
    80003140:	86ee                	mv	a3,s11
    80003142:	8656                	mv	a2,s5
    80003144:	85e2                	mv	a1,s8
    80003146:	953a                	add	a0,a0,a4
    80003148:	fffff097          	auipc	ra,0xfffff
    8000314c:	8a4080e7          	jalr	-1884(ra) # 800019ec <either_copyin>
    80003150:	07950263          	beq	a0,s9,800031b4 <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    80003154:	8526                	mv	a0,s1
    80003156:	00000097          	auipc	ra,0x0
    8000315a:	790080e7          	jalr	1936(ra) # 800038e6 <log_write>
    brelse(bp);
    8000315e:	8526                	mv	a0,s1
    80003160:	fffff097          	auipc	ra,0xfffff
    80003164:	4f0080e7          	jalr	1264(ra) # 80002650 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003168:	01498a3b          	addw	s4,s3,s4
    8000316c:	0129893b          	addw	s2,s3,s2
    80003170:	9aee                	add	s5,s5,s11
    80003172:	057a7663          	bgeu	s4,s7,800031be <writei+0xd6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80003176:	000b2483          	lw	s1,0(s6)
    8000317a:	00a9559b          	srliw	a1,s2,0xa
    8000317e:	855a                	mv	a0,s6
    80003180:	fffff097          	auipc	ra,0xfffff
    80003184:	7ae080e7          	jalr	1966(ra) # 8000292e <bmap>
    80003188:	0005059b          	sext.w	a1,a0
    8000318c:	8526                	mv	a0,s1
    8000318e:	fffff097          	auipc	ra,0xfffff
    80003192:	1f4080e7          	jalr	500(ra) # 80002382 <bread>
    80003196:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003198:	3ff97713          	andi	a4,s2,1023
    8000319c:	40ed07bb          	subw	a5,s10,a4
    800031a0:	414b86bb          	subw	a3,s7,s4
    800031a4:	89be                	mv	s3,a5
    800031a6:	2781                	sext.w	a5,a5
    800031a8:	0006861b          	sext.w	a2,a3
    800031ac:	f8f674e3          	bgeu	a2,a5,80003134 <writei+0x4c>
    800031b0:	89b6                	mv	s3,a3
    800031b2:	b749                	j	80003134 <writei+0x4c>
      brelse(bp);
    800031b4:	8526                	mv	a0,s1
    800031b6:	fffff097          	auipc	ra,0xfffff
    800031ba:	49a080e7          	jalr	1178(ra) # 80002650 <brelse>
  }

  if(off > ip->size)
    800031be:	054b2783          	lw	a5,84(s6)
    800031c2:	0127f463          	bgeu	a5,s2,800031ca <writei+0xe2>
    ip->size = off;
    800031c6:	052b2a23          	sw	s2,84(s6)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    800031ca:	855a                	mv	a0,s6
    800031cc:	00000097          	auipc	ra,0x0
    800031d0:	aa6080e7          	jalr	-1370(ra) # 80002c72 <iupdate>

  return tot;
    800031d4:	000a051b          	sext.w	a0,s4
}
    800031d8:	70a6                	ld	ra,104(sp)
    800031da:	7406                	ld	s0,96(sp)
    800031dc:	64e6                	ld	s1,88(sp)
    800031de:	6946                	ld	s2,80(sp)
    800031e0:	69a6                	ld	s3,72(sp)
    800031e2:	6a06                	ld	s4,64(sp)
    800031e4:	7ae2                	ld	s5,56(sp)
    800031e6:	7b42                	ld	s6,48(sp)
    800031e8:	7ba2                	ld	s7,40(sp)
    800031ea:	7c02                	ld	s8,32(sp)
    800031ec:	6ce2                	ld	s9,24(sp)
    800031ee:	6d42                	ld	s10,16(sp)
    800031f0:	6da2                	ld	s11,8(sp)
    800031f2:	6165                	addi	sp,sp,112
    800031f4:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800031f6:	8a5e                	mv	s4,s7
    800031f8:	bfc9                	j	800031ca <writei+0xe2>
    return -1;
    800031fa:	557d                	li	a0,-1
}
    800031fc:	8082                	ret
    return -1;
    800031fe:	557d                	li	a0,-1
    80003200:	bfe1                	j	800031d8 <writei+0xf0>
    return -1;
    80003202:	557d                	li	a0,-1
    80003204:	bfd1                	j	800031d8 <writei+0xf0>

0000000080003206 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80003206:	1141                	addi	sp,sp,-16
    80003208:	e406                	sd	ra,8(sp)
    8000320a:	e022                	sd	s0,0(sp)
    8000320c:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    8000320e:	4639                	li	a2,14
    80003210:	ffffd097          	auipc	ra,0xffffd
    80003214:	11e080e7          	jalr	286(ra) # 8000032e <strncmp>
}
    80003218:	60a2                	ld	ra,8(sp)
    8000321a:	6402                	ld	s0,0(sp)
    8000321c:	0141                	addi	sp,sp,16
    8000321e:	8082                	ret

0000000080003220 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80003220:	7139                	addi	sp,sp,-64
    80003222:	fc06                	sd	ra,56(sp)
    80003224:	f822                	sd	s0,48(sp)
    80003226:	f426                	sd	s1,40(sp)
    80003228:	f04a                	sd	s2,32(sp)
    8000322a:	ec4e                	sd	s3,24(sp)
    8000322c:	e852                	sd	s4,16(sp)
    8000322e:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80003230:	04c51703          	lh	a4,76(a0)
    80003234:	4785                	li	a5,1
    80003236:	00f71a63          	bne	a4,a5,8000324a <dirlookup+0x2a>
    8000323a:	892a                	mv	s2,a0
    8000323c:	89ae                	mv	s3,a1
    8000323e:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80003240:	497c                	lw	a5,84(a0)
    80003242:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80003244:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003246:	e79d                	bnez	a5,80003274 <dirlookup+0x54>
    80003248:	a8a5                	j	800032c0 <dirlookup+0xa0>
    panic("dirlookup not DIR");
    8000324a:	00005517          	auipc	a0,0x5
    8000324e:	31e50513          	addi	a0,a0,798 # 80008568 <syscalls+0x1a0>
    80003252:	00003097          	auipc	ra,0x3
    80003256:	eda080e7          	jalr	-294(ra) # 8000612c <panic>
      panic("dirlookup read");
    8000325a:	00005517          	auipc	a0,0x5
    8000325e:	32650513          	addi	a0,a0,806 # 80008580 <syscalls+0x1b8>
    80003262:	00003097          	auipc	ra,0x3
    80003266:	eca080e7          	jalr	-310(ra) # 8000612c <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000326a:	24c1                	addiw	s1,s1,16
    8000326c:	05492783          	lw	a5,84(s2)
    80003270:	04f4f763          	bgeu	s1,a5,800032be <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003274:	4741                	li	a4,16
    80003276:	86a6                	mv	a3,s1
    80003278:	fc040613          	addi	a2,s0,-64
    8000327c:	4581                	li	a1,0
    8000327e:	854a                	mv	a0,s2
    80003280:	00000097          	auipc	ra,0x0
    80003284:	d70080e7          	jalr	-656(ra) # 80002ff0 <readi>
    80003288:	47c1                	li	a5,16
    8000328a:	fcf518e3          	bne	a0,a5,8000325a <dirlookup+0x3a>
    if(de.inum == 0)
    8000328e:	fc045783          	lhu	a5,-64(s0)
    80003292:	dfe1                	beqz	a5,8000326a <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    80003294:	fc240593          	addi	a1,s0,-62
    80003298:	854e                	mv	a0,s3
    8000329a:	00000097          	auipc	ra,0x0
    8000329e:	f6c080e7          	jalr	-148(ra) # 80003206 <namecmp>
    800032a2:	f561                	bnez	a0,8000326a <dirlookup+0x4a>
      if(poff)
    800032a4:	000a0463          	beqz	s4,800032ac <dirlookup+0x8c>
        *poff = off;
    800032a8:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    800032ac:	fc045583          	lhu	a1,-64(s0)
    800032b0:	00092503          	lw	a0,0(s2)
    800032b4:	fffff097          	auipc	ra,0xfffff
    800032b8:	754080e7          	jalr	1876(ra) # 80002a08 <iget>
    800032bc:	a011                	j	800032c0 <dirlookup+0xa0>
  return 0;
    800032be:	4501                	li	a0,0
}
    800032c0:	70e2                	ld	ra,56(sp)
    800032c2:	7442                	ld	s0,48(sp)
    800032c4:	74a2                	ld	s1,40(sp)
    800032c6:	7902                	ld	s2,32(sp)
    800032c8:	69e2                	ld	s3,24(sp)
    800032ca:	6a42                	ld	s4,16(sp)
    800032cc:	6121                	addi	sp,sp,64
    800032ce:	8082                	ret

00000000800032d0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    800032d0:	711d                	addi	sp,sp,-96
    800032d2:	ec86                	sd	ra,88(sp)
    800032d4:	e8a2                	sd	s0,80(sp)
    800032d6:	e4a6                	sd	s1,72(sp)
    800032d8:	e0ca                	sd	s2,64(sp)
    800032da:	fc4e                	sd	s3,56(sp)
    800032dc:	f852                	sd	s4,48(sp)
    800032de:	f456                	sd	s5,40(sp)
    800032e0:	f05a                	sd	s6,32(sp)
    800032e2:	ec5e                	sd	s7,24(sp)
    800032e4:	e862                	sd	s8,16(sp)
    800032e6:	e466                	sd	s9,8(sp)
    800032e8:	1080                	addi	s0,sp,96
    800032ea:	84aa                	mv	s1,a0
    800032ec:	8b2e                	mv	s6,a1
    800032ee:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    800032f0:	00054703          	lbu	a4,0(a0)
    800032f4:	02f00793          	li	a5,47
    800032f8:	02f70363          	beq	a4,a5,8000331e <namex+0x4e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    800032fc:	ffffe097          	auipc	ra,0xffffe
    80003300:	c3a080e7          	jalr	-966(ra) # 80000f36 <myproc>
    80003304:	15853503          	ld	a0,344(a0)
    80003308:	00000097          	auipc	ra,0x0
    8000330c:	9f6080e7          	jalr	-1546(ra) # 80002cfe <idup>
    80003310:	89aa                	mv	s3,a0
  while(*path == '/')
    80003312:	02f00913          	li	s2,47
  len = path - s;
    80003316:	4b81                	li	s7,0
  if(len >= DIRSIZ)
    80003318:	4cb5                	li	s9,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    8000331a:	4c05                	li	s8,1
    8000331c:	a865                	j	800033d4 <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
    8000331e:	4585                	li	a1,1
    80003320:	4505                	li	a0,1
    80003322:	fffff097          	auipc	ra,0xfffff
    80003326:	6e6080e7          	jalr	1766(ra) # 80002a08 <iget>
    8000332a:	89aa                	mv	s3,a0
    8000332c:	b7dd                	j	80003312 <namex+0x42>
      iunlockput(ip);
    8000332e:	854e                	mv	a0,s3
    80003330:	00000097          	auipc	ra,0x0
    80003334:	c6e080e7          	jalr	-914(ra) # 80002f9e <iunlockput>
      return 0;
    80003338:	4981                	li	s3,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    8000333a:	854e                	mv	a0,s3
    8000333c:	60e6                	ld	ra,88(sp)
    8000333e:	6446                	ld	s0,80(sp)
    80003340:	64a6                	ld	s1,72(sp)
    80003342:	6906                	ld	s2,64(sp)
    80003344:	79e2                	ld	s3,56(sp)
    80003346:	7a42                	ld	s4,48(sp)
    80003348:	7aa2                	ld	s5,40(sp)
    8000334a:	7b02                	ld	s6,32(sp)
    8000334c:	6be2                	ld	s7,24(sp)
    8000334e:	6c42                	ld	s8,16(sp)
    80003350:	6ca2                	ld	s9,8(sp)
    80003352:	6125                	addi	sp,sp,96
    80003354:	8082                	ret
      iunlock(ip);
    80003356:	854e                	mv	a0,s3
    80003358:	00000097          	auipc	ra,0x0
    8000335c:	aa6080e7          	jalr	-1370(ra) # 80002dfe <iunlock>
      return ip;
    80003360:	bfe9                	j	8000333a <namex+0x6a>
      iunlockput(ip);
    80003362:	854e                	mv	a0,s3
    80003364:	00000097          	auipc	ra,0x0
    80003368:	c3a080e7          	jalr	-966(ra) # 80002f9e <iunlockput>
      return 0;
    8000336c:	89d2                	mv	s3,s4
    8000336e:	b7f1                	j	8000333a <namex+0x6a>
  len = path - s;
    80003370:	40b48633          	sub	a2,s1,a1
    80003374:	00060a1b          	sext.w	s4,a2
  if(len >= DIRSIZ)
    80003378:	094cd463          	bge	s9,s4,80003400 <namex+0x130>
    memmove(name, s, DIRSIZ);
    8000337c:	4639                	li	a2,14
    8000337e:	8556                	mv	a0,s5
    80003380:	ffffd097          	auipc	ra,0xffffd
    80003384:	f36080e7          	jalr	-202(ra) # 800002b6 <memmove>
  while(*path == '/')
    80003388:	0004c783          	lbu	a5,0(s1)
    8000338c:	01279763          	bne	a5,s2,8000339a <namex+0xca>
    path++;
    80003390:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003392:	0004c783          	lbu	a5,0(s1)
    80003396:	ff278de3          	beq	a5,s2,80003390 <namex+0xc0>
    ilock(ip);
    8000339a:	854e                	mv	a0,s3
    8000339c:	00000097          	auipc	ra,0x0
    800033a0:	9a0080e7          	jalr	-1632(ra) # 80002d3c <ilock>
    if(ip->type != T_DIR){
    800033a4:	04c99783          	lh	a5,76(s3)
    800033a8:	f98793e3          	bne	a5,s8,8000332e <namex+0x5e>
    if(nameiparent && *path == '\0'){
    800033ac:	000b0563          	beqz	s6,800033b6 <namex+0xe6>
    800033b0:	0004c783          	lbu	a5,0(s1)
    800033b4:	d3cd                	beqz	a5,80003356 <namex+0x86>
    if((next = dirlookup(ip, name, 0)) == 0){
    800033b6:	865e                	mv	a2,s7
    800033b8:	85d6                	mv	a1,s5
    800033ba:	854e                	mv	a0,s3
    800033bc:	00000097          	auipc	ra,0x0
    800033c0:	e64080e7          	jalr	-412(ra) # 80003220 <dirlookup>
    800033c4:	8a2a                	mv	s4,a0
    800033c6:	dd51                	beqz	a0,80003362 <namex+0x92>
    iunlockput(ip);
    800033c8:	854e                	mv	a0,s3
    800033ca:	00000097          	auipc	ra,0x0
    800033ce:	bd4080e7          	jalr	-1068(ra) # 80002f9e <iunlockput>
    ip = next;
    800033d2:	89d2                	mv	s3,s4
  while(*path == '/')
    800033d4:	0004c783          	lbu	a5,0(s1)
    800033d8:	05279763          	bne	a5,s2,80003426 <namex+0x156>
    path++;
    800033dc:	0485                	addi	s1,s1,1
  while(*path == '/')
    800033de:	0004c783          	lbu	a5,0(s1)
    800033e2:	ff278de3          	beq	a5,s2,800033dc <namex+0x10c>
  if(*path == 0)
    800033e6:	c79d                	beqz	a5,80003414 <namex+0x144>
    path++;
    800033e8:	85a6                	mv	a1,s1
  len = path - s;
    800033ea:	8a5e                	mv	s4,s7
    800033ec:	865e                	mv	a2,s7
  while(*path != '/' && *path != 0)
    800033ee:	01278963          	beq	a5,s2,80003400 <namex+0x130>
    800033f2:	dfbd                	beqz	a5,80003370 <namex+0xa0>
    path++;
    800033f4:	0485                	addi	s1,s1,1
  while(*path != '/' && *path != 0)
    800033f6:	0004c783          	lbu	a5,0(s1)
    800033fa:	ff279ce3          	bne	a5,s2,800033f2 <namex+0x122>
    800033fe:	bf8d                	j	80003370 <namex+0xa0>
    memmove(name, s, len);
    80003400:	2601                	sext.w	a2,a2
    80003402:	8556                	mv	a0,s5
    80003404:	ffffd097          	auipc	ra,0xffffd
    80003408:	eb2080e7          	jalr	-334(ra) # 800002b6 <memmove>
    name[len] = 0;
    8000340c:	9a56                	add	s4,s4,s5
    8000340e:	000a0023          	sb	zero,0(s4)
    80003412:	bf9d                	j	80003388 <namex+0xb8>
  if(nameiparent){
    80003414:	f20b03e3          	beqz	s6,8000333a <namex+0x6a>
    iput(ip);
    80003418:	854e                	mv	a0,s3
    8000341a:	00000097          	auipc	ra,0x0
    8000341e:	adc080e7          	jalr	-1316(ra) # 80002ef6 <iput>
    return 0;
    80003422:	4981                	li	s3,0
    80003424:	bf19                	j	8000333a <namex+0x6a>
  if(*path == 0)
    80003426:	d7fd                	beqz	a5,80003414 <namex+0x144>
  while(*path != '/' && *path != 0)
    80003428:	0004c783          	lbu	a5,0(s1)
    8000342c:	85a6                	mv	a1,s1
    8000342e:	b7d1                	j	800033f2 <namex+0x122>

0000000080003430 <dirlink>:
{
    80003430:	7139                	addi	sp,sp,-64
    80003432:	fc06                	sd	ra,56(sp)
    80003434:	f822                	sd	s0,48(sp)
    80003436:	f426                	sd	s1,40(sp)
    80003438:	f04a                	sd	s2,32(sp)
    8000343a:	ec4e                	sd	s3,24(sp)
    8000343c:	e852                	sd	s4,16(sp)
    8000343e:	0080                	addi	s0,sp,64
    80003440:	892a                	mv	s2,a0
    80003442:	8a2e                	mv	s4,a1
    80003444:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80003446:	4601                	li	a2,0
    80003448:	00000097          	auipc	ra,0x0
    8000344c:	dd8080e7          	jalr	-552(ra) # 80003220 <dirlookup>
    80003450:	e93d                	bnez	a0,800034c6 <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003452:	05492483          	lw	s1,84(s2)
    80003456:	c49d                	beqz	s1,80003484 <dirlink+0x54>
    80003458:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000345a:	4741                	li	a4,16
    8000345c:	86a6                	mv	a3,s1
    8000345e:	fc040613          	addi	a2,s0,-64
    80003462:	4581                	li	a1,0
    80003464:	854a                	mv	a0,s2
    80003466:	00000097          	auipc	ra,0x0
    8000346a:	b8a080e7          	jalr	-1142(ra) # 80002ff0 <readi>
    8000346e:	47c1                	li	a5,16
    80003470:	06f51163          	bne	a0,a5,800034d2 <dirlink+0xa2>
    if(de.inum == 0)
    80003474:	fc045783          	lhu	a5,-64(s0)
    80003478:	c791                	beqz	a5,80003484 <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000347a:	24c1                	addiw	s1,s1,16
    8000347c:	05492783          	lw	a5,84(s2)
    80003480:	fcf4ede3          	bltu	s1,a5,8000345a <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    80003484:	4639                	li	a2,14
    80003486:	85d2                	mv	a1,s4
    80003488:	fc240513          	addi	a0,s0,-62
    8000348c:	ffffd097          	auipc	ra,0xffffd
    80003490:	ede080e7          	jalr	-290(ra) # 8000036a <strncpy>
  de.inum = inum;
    80003494:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003498:	4741                	li	a4,16
    8000349a:	86a6                	mv	a3,s1
    8000349c:	fc040613          	addi	a2,s0,-64
    800034a0:	4581                	li	a1,0
    800034a2:	854a                	mv	a0,s2
    800034a4:	00000097          	auipc	ra,0x0
    800034a8:	c44080e7          	jalr	-956(ra) # 800030e8 <writei>
    800034ac:	872a                	mv	a4,a0
    800034ae:	47c1                	li	a5,16
  return 0;
    800034b0:	4501                	li	a0,0
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800034b2:	02f71863          	bne	a4,a5,800034e2 <dirlink+0xb2>
}
    800034b6:	70e2                	ld	ra,56(sp)
    800034b8:	7442                	ld	s0,48(sp)
    800034ba:	74a2                	ld	s1,40(sp)
    800034bc:	7902                	ld	s2,32(sp)
    800034be:	69e2                	ld	s3,24(sp)
    800034c0:	6a42                	ld	s4,16(sp)
    800034c2:	6121                	addi	sp,sp,64
    800034c4:	8082                	ret
    iput(ip);
    800034c6:	00000097          	auipc	ra,0x0
    800034ca:	a30080e7          	jalr	-1488(ra) # 80002ef6 <iput>
    return -1;
    800034ce:	557d                	li	a0,-1
    800034d0:	b7dd                	j	800034b6 <dirlink+0x86>
      panic("dirlink read");
    800034d2:	00005517          	auipc	a0,0x5
    800034d6:	0be50513          	addi	a0,a0,190 # 80008590 <syscalls+0x1c8>
    800034da:	00003097          	auipc	ra,0x3
    800034de:	c52080e7          	jalr	-942(ra) # 8000612c <panic>
    panic("dirlink");
    800034e2:	00005517          	auipc	a0,0x5
    800034e6:	1be50513          	addi	a0,a0,446 # 800086a0 <syscalls+0x2d8>
    800034ea:	00003097          	auipc	ra,0x3
    800034ee:	c42080e7          	jalr	-958(ra) # 8000612c <panic>

00000000800034f2 <namei>:

struct inode*
namei(char *path)
{
    800034f2:	1101                	addi	sp,sp,-32
    800034f4:	ec06                	sd	ra,24(sp)
    800034f6:	e822                	sd	s0,16(sp)
    800034f8:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    800034fa:	fe040613          	addi	a2,s0,-32
    800034fe:	4581                	li	a1,0
    80003500:	00000097          	auipc	ra,0x0
    80003504:	dd0080e7          	jalr	-560(ra) # 800032d0 <namex>
}
    80003508:	60e2                	ld	ra,24(sp)
    8000350a:	6442                	ld	s0,16(sp)
    8000350c:	6105                	addi	sp,sp,32
    8000350e:	8082                	ret

0000000080003510 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80003510:	1141                	addi	sp,sp,-16
    80003512:	e406                	sd	ra,8(sp)
    80003514:	e022                	sd	s0,0(sp)
    80003516:	0800                	addi	s0,sp,16
    80003518:	862e                	mv	a2,a1
  return namex(path, 1, name);
    8000351a:	4585                	li	a1,1
    8000351c:	00000097          	auipc	ra,0x0
    80003520:	db4080e7          	jalr	-588(ra) # 800032d0 <namex>
}
    80003524:	60a2                	ld	ra,8(sp)
    80003526:	6402                	ld	s0,0(sp)
    80003528:	0141                	addi	sp,sp,16
    8000352a:	8082                	ret

000000008000352c <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    8000352c:	1101                	addi	sp,sp,-32
    8000352e:	ec06                	sd	ra,24(sp)
    80003530:	e822                	sd	s0,16(sp)
    80003532:	e426                	sd	s1,8(sp)
    80003534:	e04a                	sd	s2,0(sp)
    80003536:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80003538:	0001a917          	auipc	s2,0x1a
    8000353c:	81090913          	addi	s2,s2,-2032 # 8001cd48 <log>
    80003540:	02092583          	lw	a1,32(s2)
    80003544:	03092503          	lw	a0,48(s2)
    80003548:	fffff097          	auipc	ra,0xfffff
    8000354c:	e3a080e7          	jalr	-454(ra) # 80002382 <bread>
    80003550:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80003552:	03492683          	lw	a3,52(s2)
    80003556:	d134                	sw	a3,96(a0)
  for (i = 0; i < log.lh.n; i++) {
    80003558:	02d05763          	blez	a3,80003586 <write_head+0x5a>
    8000355c:	0001a797          	auipc	a5,0x1a
    80003560:	82478793          	addi	a5,a5,-2012 # 8001cd80 <log+0x38>
    80003564:	06450713          	addi	a4,a0,100
    80003568:	36fd                	addiw	a3,a3,-1
    8000356a:	1682                	slli	a3,a3,0x20
    8000356c:	9281                	srli	a3,a3,0x20
    8000356e:	068a                	slli	a3,a3,0x2
    80003570:	0001a617          	auipc	a2,0x1a
    80003574:	81460613          	addi	a2,a2,-2028 # 8001cd84 <log+0x3c>
    80003578:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    8000357a:	4390                	lw	a2,0(a5)
    8000357c:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    8000357e:	0791                	addi	a5,a5,4
    80003580:	0711                	addi	a4,a4,4
    80003582:	fed79ce3          	bne	a5,a3,8000357a <write_head+0x4e>
  }
  bwrite(buf);
    80003586:	8526                	mv	a0,s1
    80003588:	fffff097          	auipc	ra,0xfffff
    8000358c:	08a080e7          	jalr	138(ra) # 80002612 <bwrite>
  brelse(buf);
    80003590:	8526                	mv	a0,s1
    80003592:	fffff097          	auipc	ra,0xfffff
    80003596:	0be080e7          	jalr	190(ra) # 80002650 <brelse>
}
    8000359a:	60e2                	ld	ra,24(sp)
    8000359c:	6442                	ld	s0,16(sp)
    8000359e:	64a2                	ld	s1,8(sp)
    800035a0:	6902                	ld	s2,0(sp)
    800035a2:	6105                	addi	sp,sp,32
    800035a4:	8082                	ret

00000000800035a6 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    800035a6:	00019797          	auipc	a5,0x19
    800035aa:	7d67a783          	lw	a5,2006(a5) # 8001cd7c <log+0x34>
    800035ae:	0af05d63          	blez	a5,80003668 <install_trans+0xc2>
{
    800035b2:	7139                	addi	sp,sp,-64
    800035b4:	fc06                	sd	ra,56(sp)
    800035b6:	f822                	sd	s0,48(sp)
    800035b8:	f426                	sd	s1,40(sp)
    800035ba:	f04a                	sd	s2,32(sp)
    800035bc:	ec4e                	sd	s3,24(sp)
    800035be:	e852                	sd	s4,16(sp)
    800035c0:	e456                	sd	s5,8(sp)
    800035c2:	e05a                	sd	s6,0(sp)
    800035c4:	0080                	addi	s0,sp,64
    800035c6:	8b2a                	mv	s6,a0
    800035c8:	00019a97          	auipc	s5,0x19
    800035cc:	7b8a8a93          	addi	s5,s5,1976 # 8001cd80 <log+0x38>
  for (tail = 0; tail < log.lh.n; tail++) {
    800035d0:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800035d2:	00019997          	auipc	s3,0x19
    800035d6:	77698993          	addi	s3,s3,1910 # 8001cd48 <log>
    800035da:	a035                	j	80003606 <install_trans+0x60>
      bunpin(dbuf);
    800035dc:	8526                	mv	a0,s1
    800035de:	fffff097          	auipc	ra,0xfffff
    800035e2:	146080e7          	jalr	326(ra) # 80002724 <bunpin>
    brelse(lbuf);
    800035e6:	854a                	mv	a0,s2
    800035e8:	fffff097          	auipc	ra,0xfffff
    800035ec:	068080e7          	jalr	104(ra) # 80002650 <brelse>
    brelse(dbuf);
    800035f0:	8526                	mv	a0,s1
    800035f2:	fffff097          	auipc	ra,0xfffff
    800035f6:	05e080e7          	jalr	94(ra) # 80002650 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800035fa:	2a05                	addiw	s4,s4,1
    800035fc:	0a91                	addi	s5,s5,4
    800035fe:	0349a783          	lw	a5,52(s3)
    80003602:	04fa5963          	bge	s4,a5,80003654 <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003606:	0209a583          	lw	a1,32(s3)
    8000360a:	014585bb          	addw	a1,a1,s4
    8000360e:	2585                	addiw	a1,a1,1
    80003610:	0309a503          	lw	a0,48(s3)
    80003614:	fffff097          	auipc	ra,0xfffff
    80003618:	d6e080e7          	jalr	-658(ra) # 80002382 <bread>
    8000361c:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    8000361e:	000aa583          	lw	a1,0(s5)
    80003622:	0309a503          	lw	a0,48(s3)
    80003626:	fffff097          	auipc	ra,0xfffff
    8000362a:	d5c080e7          	jalr	-676(ra) # 80002382 <bread>
    8000362e:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80003630:	40000613          	li	a2,1024
    80003634:	06090593          	addi	a1,s2,96
    80003638:	06050513          	addi	a0,a0,96
    8000363c:	ffffd097          	auipc	ra,0xffffd
    80003640:	c7a080e7          	jalr	-902(ra) # 800002b6 <memmove>
    bwrite(dbuf);  // write dst to disk
    80003644:	8526                	mv	a0,s1
    80003646:	fffff097          	auipc	ra,0xfffff
    8000364a:	fcc080e7          	jalr	-52(ra) # 80002612 <bwrite>
    if(recovering == 0)
    8000364e:	f80b1ce3          	bnez	s6,800035e6 <install_trans+0x40>
    80003652:	b769                	j	800035dc <install_trans+0x36>
}
    80003654:	70e2                	ld	ra,56(sp)
    80003656:	7442                	ld	s0,48(sp)
    80003658:	74a2                	ld	s1,40(sp)
    8000365a:	7902                	ld	s2,32(sp)
    8000365c:	69e2                	ld	s3,24(sp)
    8000365e:	6a42                	ld	s4,16(sp)
    80003660:	6aa2                	ld	s5,8(sp)
    80003662:	6b02                	ld	s6,0(sp)
    80003664:	6121                	addi	sp,sp,64
    80003666:	8082                	ret
    80003668:	8082                	ret

000000008000366a <initlog>:
{
    8000366a:	7179                	addi	sp,sp,-48
    8000366c:	f406                	sd	ra,40(sp)
    8000366e:	f022                	sd	s0,32(sp)
    80003670:	ec26                	sd	s1,24(sp)
    80003672:	e84a                	sd	s2,16(sp)
    80003674:	e44e                	sd	s3,8(sp)
    80003676:	1800                	addi	s0,sp,48
    80003678:	892a                	mv	s2,a0
    8000367a:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    8000367c:	00019497          	auipc	s1,0x19
    80003680:	6cc48493          	addi	s1,s1,1740 # 8001cd48 <log>
    80003684:	00005597          	auipc	a1,0x5
    80003688:	f1c58593          	addi	a1,a1,-228 # 800085a0 <syscalls+0x1d8>
    8000368c:	8526                	mv	a0,s1
    8000368e:	00003097          	auipc	ra,0x3
    80003692:	14e080e7          	jalr	334(ra) # 800067dc <initlock>
  log.start = sb->logstart;
    80003696:	0149a583          	lw	a1,20(s3)
    8000369a:	d08c                	sw	a1,32(s1)
  log.size = sb->nlog;
    8000369c:	0109a783          	lw	a5,16(s3)
    800036a0:	d0dc                	sw	a5,36(s1)
  log.dev = dev;
    800036a2:	0324a823          	sw	s2,48(s1)
  struct buf *buf = bread(log.dev, log.start);
    800036a6:	854a                	mv	a0,s2
    800036a8:	fffff097          	auipc	ra,0xfffff
    800036ac:	cda080e7          	jalr	-806(ra) # 80002382 <bread>
  log.lh.n = lh->n;
    800036b0:	513c                	lw	a5,96(a0)
    800036b2:	d8dc                	sw	a5,52(s1)
  for (i = 0; i < log.lh.n; i++) {
    800036b4:	02f05563          	blez	a5,800036de <initlog+0x74>
    800036b8:	06450713          	addi	a4,a0,100
    800036bc:	00019697          	auipc	a3,0x19
    800036c0:	6c468693          	addi	a3,a3,1732 # 8001cd80 <log+0x38>
    800036c4:	37fd                	addiw	a5,a5,-1
    800036c6:	1782                	slli	a5,a5,0x20
    800036c8:	9381                	srli	a5,a5,0x20
    800036ca:	078a                	slli	a5,a5,0x2
    800036cc:	06850613          	addi	a2,a0,104
    800036d0:	97b2                	add	a5,a5,a2
    log.lh.block[i] = lh->block[i];
    800036d2:	4310                	lw	a2,0(a4)
    800036d4:	c290                	sw	a2,0(a3)
  for (i = 0; i < log.lh.n; i++) {
    800036d6:	0711                	addi	a4,a4,4
    800036d8:	0691                	addi	a3,a3,4
    800036da:	fef71ce3          	bne	a4,a5,800036d2 <initlog+0x68>
  brelse(buf);
    800036de:	fffff097          	auipc	ra,0xfffff
    800036e2:	f72080e7          	jalr	-142(ra) # 80002650 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    800036e6:	4505                	li	a0,1
    800036e8:	00000097          	auipc	ra,0x0
    800036ec:	ebe080e7          	jalr	-322(ra) # 800035a6 <install_trans>
  log.lh.n = 0;
    800036f0:	00019797          	auipc	a5,0x19
    800036f4:	6807a623          	sw	zero,1676(a5) # 8001cd7c <log+0x34>
  write_head(); // clear the log
    800036f8:	00000097          	auipc	ra,0x0
    800036fc:	e34080e7          	jalr	-460(ra) # 8000352c <write_head>
}
    80003700:	70a2                	ld	ra,40(sp)
    80003702:	7402                	ld	s0,32(sp)
    80003704:	64e2                	ld	s1,24(sp)
    80003706:	6942                	ld	s2,16(sp)
    80003708:	69a2                	ld	s3,8(sp)
    8000370a:	6145                	addi	sp,sp,48
    8000370c:	8082                	ret

000000008000370e <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    8000370e:	1101                	addi	sp,sp,-32
    80003710:	ec06                	sd	ra,24(sp)
    80003712:	e822                	sd	s0,16(sp)
    80003714:	e426                	sd	s1,8(sp)
    80003716:	e04a                	sd	s2,0(sp)
    80003718:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    8000371a:	00019517          	auipc	a0,0x19
    8000371e:	62e50513          	addi	a0,a0,1582 # 8001cd48 <log>
    80003722:	00003097          	auipc	ra,0x3
    80003726:	f3e080e7          	jalr	-194(ra) # 80006660 <acquire>
  while(1){
    if(log.committing){
    8000372a:	00019497          	auipc	s1,0x19
    8000372e:	61e48493          	addi	s1,s1,1566 # 8001cd48 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003732:	4979                	li	s2,30
    80003734:	a039                	j	80003742 <begin_op+0x34>
      sleep(&log, &log.lock);
    80003736:	85a6                	mv	a1,s1
    80003738:	8526                	mv	a0,s1
    8000373a:	ffffe097          	auipc	ra,0xffffe
    8000373e:	eb8080e7          	jalr	-328(ra) # 800015f2 <sleep>
    if(log.committing){
    80003742:	54dc                	lw	a5,44(s1)
    80003744:	fbed                	bnez	a5,80003736 <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003746:	549c                	lw	a5,40(s1)
    80003748:	0017871b          	addiw	a4,a5,1
    8000374c:	0007069b          	sext.w	a3,a4
    80003750:	0027179b          	slliw	a5,a4,0x2
    80003754:	9fb9                	addw	a5,a5,a4
    80003756:	0017979b          	slliw	a5,a5,0x1
    8000375a:	58d8                	lw	a4,52(s1)
    8000375c:	9fb9                	addw	a5,a5,a4
    8000375e:	00f95963          	bge	s2,a5,80003770 <begin_op+0x62>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80003762:	85a6                	mv	a1,s1
    80003764:	8526                	mv	a0,s1
    80003766:	ffffe097          	auipc	ra,0xffffe
    8000376a:	e8c080e7          	jalr	-372(ra) # 800015f2 <sleep>
    8000376e:	bfd1                	j	80003742 <begin_op+0x34>
    } else {
      log.outstanding += 1;
    80003770:	00019517          	auipc	a0,0x19
    80003774:	5d850513          	addi	a0,a0,1496 # 8001cd48 <log>
    80003778:	d514                	sw	a3,40(a0)
      release(&log.lock);
    8000377a:	00003097          	auipc	ra,0x3
    8000377e:	fb6080e7          	jalr	-74(ra) # 80006730 <release>
      break;
    }
  }
}
    80003782:	60e2                	ld	ra,24(sp)
    80003784:	6442                	ld	s0,16(sp)
    80003786:	64a2                	ld	s1,8(sp)
    80003788:	6902                	ld	s2,0(sp)
    8000378a:	6105                	addi	sp,sp,32
    8000378c:	8082                	ret

000000008000378e <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    8000378e:	7139                	addi	sp,sp,-64
    80003790:	fc06                	sd	ra,56(sp)
    80003792:	f822                	sd	s0,48(sp)
    80003794:	f426                	sd	s1,40(sp)
    80003796:	f04a                	sd	s2,32(sp)
    80003798:	ec4e                	sd	s3,24(sp)
    8000379a:	e852                	sd	s4,16(sp)
    8000379c:	e456                	sd	s5,8(sp)
    8000379e:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    800037a0:	00019497          	auipc	s1,0x19
    800037a4:	5a848493          	addi	s1,s1,1448 # 8001cd48 <log>
    800037a8:	8526                	mv	a0,s1
    800037aa:	00003097          	auipc	ra,0x3
    800037ae:	eb6080e7          	jalr	-330(ra) # 80006660 <acquire>
  log.outstanding -= 1;
    800037b2:	549c                	lw	a5,40(s1)
    800037b4:	37fd                	addiw	a5,a5,-1
    800037b6:	0007891b          	sext.w	s2,a5
    800037ba:	d49c                	sw	a5,40(s1)
  if(log.committing)
    800037bc:	54dc                	lw	a5,44(s1)
    800037be:	efb9                	bnez	a5,8000381c <end_op+0x8e>
    panic("log.committing");
  if(log.outstanding == 0){
    800037c0:	06091663          	bnez	s2,8000382c <end_op+0x9e>
    do_commit = 1;
    log.committing = 1;
    800037c4:	00019497          	auipc	s1,0x19
    800037c8:	58448493          	addi	s1,s1,1412 # 8001cd48 <log>
    800037cc:	4785                	li	a5,1
    800037ce:	d4dc                	sw	a5,44(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    800037d0:	8526                	mv	a0,s1
    800037d2:	00003097          	auipc	ra,0x3
    800037d6:	f5e080e7          	jalr	-162(ra) # 80006730 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    800037da:	58dc                	lw	a5,52(s1)
    800037dc:	06f04763          	bgtz	a5,8000384a <end_op+0xbc>
    acquire(&log.lock);
    800037e0:	00019497          	auipc	s1,0x19
    800037e4:	56848493          	addi	s1,s1,1384 # 8001cd48 <log>
    800037e8:	8526                	mv	a0,s1
    800037ea:	00003097          	auipc	ra,0x3
    800037ee:	e76080e7          	jalr	-394(ra) # 80006660 <acquire>
    log.committing = 0;
    800037f2:	0204a623          	sw	zero,44(s1)
    wakeup(&log);
    800037f6:	8526                	mv	a0,s1
    800037f8:	ffffe097          	auipc	ra,0xffffe
    800037fc:	f86080e7          	jalr	-122(ra) # 8000177e <wakeup>
    release(&log.lock);
    80003800:	8526                	mv	a0,s1
    80003802:	00003097          	auipc	ra,0x3
    80003806:	f2e080e7          	jalr	-210(ra) # 80006730 <release>
}
    8000380a:	70e2                	ld	ra,56(sp)
    8000380c:	7442                	ld	s0,48(sp)
    8000380e:	74a2                	ld	s1,40(sp)
    80003810:	7902                	ld	s2,32(sp)
    80003812:	69e2                	ld	s3,24(sp)
    80003814:	6a42                	ld	s4,16(sp)
    80003816:	6aa2                	ld	s5,8(sp)
    80003818:	6121                	addi	sp,sp,64
    8000381a:	8082                	ret
    panic("log.committing");
    8000381c:	00005517          	auipc	a0,0x5
    80003820:	d8c50513          	addi	a0,a0,-628 # 800085a8 <syscalls+0x1e0>
    80003824:	00003097          	auipc	ra,0x3
    80003828:	908080e7          	jalr	-1784(ra) # 8000612c <panic>
    wakeup(&log);
    8000382c:	00019497          	auipc	s1,0x19
    80003830:	51c48493          	addi	s1,s1,1308 # 8001cd48 <log>
    80003834:	8526                	mv	a0,s1
    80003836:	ffffe097          	auipc	ra,0xffffe
    8000383a:	f48080e7          	jalr	-184(ra) # 8000177e <wakeup>
  release(&log.lock);
    8000383e:	8526                	mv	a0,s1
    80003840:	00003097          	auipc	ra,0x3
    80003844:	ef0080e7          	jalr	-272(ra) # 80006730 <release>
  if(do_commit){
    80003848:	b7c9                	j	8000380a <end_op+0x7c>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000384a:	00019a97          	auipc	s5,0x19
    8000384e:	536a8a93          	addi	s5,s5,1334 # 8001cd80 <log+0x38>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80003852:	00019a17          	auipc	s4,0x19
    80003856:	4f6a0a13          	addi	s4,s4,1270 # 8001cd48 <log>
    8000385a:	020a2583          	lw	a1,32(s4)
    8000385e:	012585bb          	addw	a1,a1,s2
    80003862:	2585                	addiw	a1,a1,1
    80003864:	030a2503          	lw	a0,48(s4)
    80003868:	fffff097          	auipc	ra,0xfffff
    8000386c:	b1a080e7          	jalr	-1254(ra) # 80002382 <bread>
    80003870:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80003872:	000aa583          	lw	a1,0(s5)
    80003876:	030a2503          	lw	a0,48(s4)
    8000387a:	fffff097          	auipc	ra,0xfffff
    8000387e:	b08080e7          	jalr	-1272(ra) # 80002382 <bread>
    80003882:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    80003884:	40000613          	li	a2,1024
    80003888:	06050593          	addi	a1,a0,96
    8000388c:	06048513          	addi	a0,s1,96
    80003890:	ffffd097          	auipc	ra,0xffffd
    80003894:	a26080e7          	jalr	-1498(ra) # 800002b6 <memmove>
    bwrite(to);  // write the log
    80003898:	8526                	mv	a0,s1
    8000389a:	fffff097          	auipc	ra,0xfffff
    8000389e:	d78080e7          	jalr	-648(ra) # 80002612 <bwrite>
    brelse(from);
    800038a2:	854e                	mv	a0,s3
    800038a4:	fffff097          	auipc	ra,0xfffff
    800038a8:	dac080e7          	jalr	-596(ra) # 80002650 <brelse>
    brelse(to);
    800038ac:	8526                	mv	a0,s1
    800038ae:	fffff097          	auipc	ra,0xfffff
    800038b2:	da2080e7          	jalr	-606(ra) # 80002650 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800038b6:	2905                	addiw	s2,s2,1
    800038b8:	0a91                	addi	s5,s5,4
    800038ba:	034a2783          	lw	a5,52(s4)
    800038be:	f8f94ee3          	blt	s2,a5,8000385a <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    800038c2:	00000097          	auipc	ra,0x0
    800038c6:	c6a080e7          	jalr	-918(ra) # 8000352c <write_head>
    install_trans(0); // Now install writes to home locations
    800038ca:	4501                	li	a0,0
    800038cc:	00000097          	auipc	ra,0x0
    800038d0:	cda080e7          	jalr	-806(ra) # 800035a6 <install_trans>
    log.lh.n = 0;
    800038d4:	00019797          	auipc	a5,0x19
    800038d8:	4a07a423          	sw	zero,1192(a5) # 8001cd7c <log+0x34>
    write_head();    // Erase the transaction from the log
    800038dc:	00000097          	auipc	ra,0x0
    800038e0:	c50080e7          	jalr	-944(ra) # 8000352c <write_head>
    800038e4:	bdf5                	j	800037e0 <end_op+0x52>

00000000800038e6 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800038e6:	1101                	addi	sp,sp,-32
    800038e8:	ec06                	sd	ra,24(sp)
    800038ea:	e822                	sd	s0,16(sp)
    800038ec:	e426                	sd	s1,8(sp)
    800038ee:	e04a                	sd	s2,0(sp)
    800038f0:	1000                	addi	s0,sp,32
    800038f2:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    800038f4:	00019917          	auipc	s2,0x19
    800038f8:	45490913          	addi	s2,s2,1108 # 8001cd48 <log>
    800038fc:	854a                	mv	a0,s2
    800038fe:	00003097          	auipc	ra,0x3
    80003902:	d62080e7          	jalr	-670(ra) # 80006660 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80003906:	03492603          	lw	a2,52(s2)
    8000390a:	47f5                	li	a5,29
    8000390c:	06c7c563          	blt	a5,a2,80003976 <log_write+0x90>
    80003910:	00019797          	auipc	a5,0x19
    80003914:	45c7a783          	lw	a5,1116(a5) # 8001cd6c <log+0x24>
    80003918:	37fd                	addiw	a5,a5,-1
    8000391a:	04f65e63          	bge	a2,a5,80003976 <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    8000391e:	00019797          	auipc	a5,0x19
    80003922:	4527a783          	lw	a5,1106(a5) # 8001cd70 <log+0x28>
    80003926:	06f05063          	blez	a5,80003986 <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    8000392a:	4781                	li	a5,0
    8000392c:	06c05563          	blez	a2,80003996 <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003930:	44cc                	lw	a1,12(s1)
    80003932:	00019717          	auipc	a4,0x19
    80003936:	44e70713          	addi	a4,a4,1102 # 8001cd80 <log+0x38>
  for (i = 0; i < log.lh.n; i++) {
    8000393a:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    8000393c:	4314                	lw	a3,0(a4)
    8000393e:	04b68c63          	beq	a3,a1,80003996 <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    80003942:	2785                	addiw	a5,a5,1
    80003944:	0711                	addi	a4,a4,4
    80003946:	fef61be3          	bne	a2,a5,8000393c <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    8000394a:	0631                	addi	a2,a2,12
    8000394c:	060a                	slli	a2,a2,0x2
    8000394e:	00019797          	auipc	a5,0x19
    80003952:	3fa78793          	addi	a5,a5,1018 # 8001cd48 <log>
    80003956:	963e                	add	a2,a2,a5
    80003958:	44dc                	lw	a5,12(s1)
    8000395a:	c61c                	sw	a5,8(a2)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    8000395c:	8526                	mv	a0,s1
    8000395e:	fffff097          	auipc	ra,0xfffff
    80003962:	d6a080e7          	jalr	-662(ra) # 800026c8 <bpin>
    log.lh.n++;
    80003966:	00019717          	auipc	a4,0x19
    8000396a:	3e270713          	addi	a4,a4,994 # 8001cd48 <log>
    8000396e:	5b5c                	lw	a5,52(a4)
    80003970:	2785                	addiw	a5,a5,1
    80003972:	db5c                	sw	a5,52(a4)
    80003974:	a835                	j	800039b0 <log_write+0xca>
    panic("too big a transaction");
    80003976:	00005517          	auipc	a0,0x5
    8000397a:	c4250513          	addi	a0,a0,-958 # 800085b8 <syscalls+0x1f0>
    8000397e:	00002097          	auipc	ra,0x2
    80003982:	7ae080e7          	jalr	1966(ra) # 8000612c <panic>
    panic("log_write outside of trans");
    80003986:	00005517          	auipc	a0,0x5
    8000398a:	c4a50513          	addi	a0,a0,-950 # 800085d0 <syscalls+0x208>
    8000398e:	00002097          	auipc	ra,0x2
    80003992:	79e080e7          	jalr	1950(ra) # 8000612c <panic>
  log.lh.block[i] = b->blockno;
    80003996:	00c78713          	addi	a4,a5,12
    8000399a:	00271693          	slli	a3,a4,0x2
    8000399e:	00019717          	auipc	a4,0x19
    800039a2:	3aa70713          	addi	a4,a4,938 # 8001cd48 <log>
    800039a6:	9736                	add	a4,a4,a3
    800039a8:	44d4                	lw	a3,12(s1)
    800039aa:	c714                	sw	a3,8(a4)
  if (i == log.lh.n) {  // Add new block to log?
    800039ac:	faf608e3          	beq	a2,a5,8000395c <log_write+0x76>
  }
  release(&log.lock);
    800039b0:	00019517          	auipc	a0,0x19
    800039b4:	39850513          	addi	a0,a0,920 # 8001cd48 <log>
    800039b8:	00003097          	auipc	ra,0x3
    800039bc:	d78080e7          	jalr	-648(ra) # 80006730 <release>
}
    800039c0:	60e2                	ld	ra,24(sp)
    800039c2:	6442                	ld	s0,16(sp)
    800039c4:	64a2                	ld	s1,8(sp)
    800039c6:	6902                	ld	s2,0(sp)
    800039c8:	6105                	addi	sp,sp,32
    800039ca:	8082                	ret

00000000800039cc <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    800039cc:	1101                	addi	sp,sp,-32
    800039ce:	ec06                	sd	ra,24(sp)
    800039d0:	e822                	sd	s0,16(sp)
    800039d2:	e426                	sd	s1,8(sp)
    800039d4:	e04a                	sd	s2,0(sp)
    800039d6:	1000                	addi	s0,sp,32
    800039d8:	84aa                	mv	s1,a0
    800039da:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    800039dc:	00005597          	auipc	a1,0x5
    800039e0:	c1458593          	addi	a1,a1,-1004 # 800085f0 <syscalls+0x228>
    800039e4:	0521                	addi	a0,a0,8
    800039e6:	00003097          	auipc	ra,0x3
    800039ea:	df6080e7          	jalr	-522(ra) # 800067dc <initlock>
  lk->name = name;
    800039ee:	0324b423          	sd	s2,40(s1)
  lk->locked = 0;
    800039f2:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800039f6:	0204a823          	sw	zero,48(s1)
}
    800039fa:	60e2                	ld	ra,24(sp)
    800039fc:	6442                	ld	s0,16(sp)
    800039fe:	64a2                	ld	s1,8(sp)
    80003a00:	6902                	ld	s2,0(sp)
    80003a02:	6105                	addi	sp,sp,32
    80003a04:	8082                	ret

0000000080003a06 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80003a06:	1101                	addi	sp,sp,-32
    80003a08:	ec06                	sd	ra,24(sp)
    80003a0a:	e822                	sd	s0,16(sp)
    80003a0c:	e426                	sd	s1,8(sp)
    80003a0e:	e04a                	sd	s2,0(sp)
    80003a10:	1000                	addi	s0,sp,32
    80003a12:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003a14:	00850913          	addi	s2,a0,8
    80003a18:	854a                	mv	a0,s2
    80003a1a:	00003097          	auipc	ra,0x3
    80003a1e:	c46080e7          	jalr	-954(ra) # 80006660 <acquire>
  while (lk->locked) {
    80003a22:	409c                	lw	a5,0(s1)
    80003a24:	cb89                	beqz	a5,80003a36 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80003a26:	85ca                	mv	a1,s2
    80003a28:	8526                	mv	a0,s1
    80003a2a:	ffffe097          	auipc	ra,0xffffe
    80003a2e:	bc8080e7          	jalr	-1080(ra) # 800015f2 <sleep>
  while (lk->locked) {
    80003a32:	409c                	lw	a5,0(s1)
    80003a34:	fbed                	bnez	a5,80003a26 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80003a36:	4785                	li	a5,1
    80003a38:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80003a3a:	ffffd097          	auipc	ra,0xffffd
    80003a3e:	4fc080e7          	jalr	1276(ra) # 80000f36 <myproc>
    80003a42:	5d1c                	lw	a5,56(a0)
    80003a44:	d89c                	sw	a5,48(s1)
  release(&lk->lk);
    80003a46:	854a                	mv	a0,s2
    80003a48:	00003097          	auipc	ra,0x3
    80003a4c:	ce8080e7          	jalr	-792(ra) # 80006730 <release>
}
    80003a50:	60e2                	ld	ra,24(sp)
    80003a52:	6442                	ld	s0,16(sp)
    80003a54:	64a2                	ld	s1,8(sp)
    80003a56:	6902                	ld	s2,0(sp)
    80003a58:	6105                	addi	sp,sp,32
    80003a5a:	8082                	ret

0000000080003a5c <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80003a5c:	1101                	addi	sp,sp,-32
    80003a5e:	ec06                	sd	ra,24(sp)
    80003a60:	e822                	sd	s0,16(sp)
    80003a62:	e426                	sd	s1,8(sp)
    80003a64:	e04a                	sd	s2,0(sp)
    80003a66:	1000                	addi	s0,sp,32
    80003a68:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003a6a:	00850913          	addi	s2,a0,8
    80003a6e:	854a                	mv	a0,s2
    80003a70:	00003097          	auipc	ra,0x3
    80003a74:	bf0080e7          	jalr	-1040(ra) # 80006660 <acquire>
  lk->locked = 0;
    80003a78:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003a7c:	0204a823          	sw	zero,48(s1)
  wakeup(lk);
    80003a80:	8526                	mv	a0,s1
    80003a82:	ffffe097          	auipc	ra,0xffffe
    80003a86:	cfc080e7          	jalr	-772(ra) # 8000177e <wakeup>
  release(&lk->lk);
    80003a8a:	854a                	mv	a0,s2
    80003a8c:	00003097          	auipc	ra,0x3
    80003a90:	ca4080e7          	jalr	-860(ra) # 80006730 <release>
}
    80003a94:	60e2                	ld	ra,24(sp)
    80003a96:	6442                	ld	s0,16(sp)
    80003a98:	64a2                	ld	s1,8(sp)
    80003a9a:	6902                	ld	s2,0(sp)
    80003a9c:	6105                	addi	sp,sp,32
    80003a9e:	8082                	ret

0000000080003aa0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80003aa0:	7179                	addi	sp,sp,-48
    80003aa2:	f406                	sd	ra,40(sp)
    80003aa4:	f022                	sd	s0,32(sp)
    80003aa6:	ec26                	sd	s1,24(sp)
    80003aa8:	e84a                	sd	s2,16(sp)
    80003aaa:	e44e                	sd	s3,8(sp)
    80003aac:	1800                	addi	s0,sp,48
    80003aae:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80003ab0:	00850913          	addi	s2,a0,8
    80003ab4:	854a                	mv	a0,s2
    80003ab6:	00003097          	auipc	ra,0x3
    80003aba:	baa080e7          	jalr	-1110(ra) # 80006660 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80003abe:	409c                	lw	a5,0(s1)
    80003ac0:	ef99                	bnez	a5,80003ade <holdingsleep+0x3e>
    80003ac2:	4481                	li	s1,0
  release(&lk->lk);
    80003ac4:	854a                	mv	a0,s2
    80003ac6:	00003097          	auipc	ra,0x3
    80003aca:	c6a080e7          	jalr	-918(ra) # 80006730 <release>
  return r;
}
    80003ace:	8526                	mv	a0,s1
    80003ad0:	70a2                	ld	ra,40(sp)
    80003ad2:	7402                	ld	s0,32(sp)
    80003ad4:	64e2                	ld	s1,24(sp)
    80003ad6:	6942                	ld	s2,16(sp)
    80003ad8:	69a2                	ld	s3,8(sp)
    80003ada:	6145                	addi	sp,sp,48
    80003adc:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80003ade:	0304a983          	lw	s3,48(s1)
    80003ae2:	ffffd097          	auipc	ra,0xffffd
    80003ae6:	454080e7          	jalr	1108(ra) # 80000f36 <myproc>
    80003aea:	5d04                	lw	s1,56(a0)
    80003aec:	413484b3          	sub	s1,s1,s3
    80003af0:	0014b493          	seqz	s1,s1
    80003af4:	bfc1                	j	80003ac4 <holdingsleep+0x24>

0000000080003af6 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80003af6:	1141                	addi	sp,sp,-16
    80003af8:	e406                	sd	ra,8(sp)
    80003afa:	e022                	sd	s0,0(sp)
    80003afc:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003afe:	00005597          	auipc	a1,0x5
    80003b02:	b0258593          	addi	a1,a1,-1278 # 80008600 <syscalls+0x238>
    80003b06:	00019517          	auipc	a0,0x19
    80003b0a:	39250513          	addi	a0,a0,914 # 8001ce98 <ftable>
    80003b0e:	00003097          	auipc	ra,0x3
    80003b12:	cce080e7          	jalr	-818(ra) # 800067dc <initlock>
}
    80003b16:	60a2                	ld	ra,8(sp)
    80003b18:	6402                	ld	s0,0(sp)
    80003b1a:	0141                	addi	sp,sp,16
    80003b1c:	8082                	ret

0000000080003b1e <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003b1e:	1101                	addi	sp,sp,-32
    80003b20:	ec06                	sd	ra,24(sp)
    80003b22:	e822                	sd	s0,16(sp)
    80003b24:	e426                	sd	s1,8(sp)
    80003b26:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80003b28:	00019517          	auipc	a0,0x19
    80003b2c:	37050513          	addi	a0,a0,880 # 8001ce98 <ftable>
    80003b30:	00003097          	auipc	ra,0x3
    80003b34:	b30080e7          	jalr	-1232(ra) # 80006660 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003b38:	00019497          	auipc	s1,0x19
    80003b3c:	38048493          	addi	s1,s1,896 # 8001ceb8 <ftable+0x20>
    80003b40:	0001a717          	auipc	a4,0x1a
    80003b44:	31870713          	addi	a4,a4,792 # 8001de58 <ftable+0xfc0>
    if(f->ref == 0){
    80003b48:	40dc                	lw	a5,4(s1)
    80003b4a:	cf99                	beqz	a5,80003b68 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003b4c:	02848493          	addi	s1,s1,40
    80003b50:	fee49ce3          	bne	s1,a4,80003b48 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80003b54:	00019517          	auipc	a0,0x19
    80003b58:	34450513          	addi	a0,a0,836 # 8001ce98 <ftable>
    80003b5c:	00003097          	auipc	ra,0x3
    80003b60:	bd4080e7          	jalr	-1068(ra) # 80006730 <release>
  return 0;
    80003b64:	4481                	li	s1,0
    80003b66:	a819                	j	80003b7c <filealloc+0x5e>
      f->ref = 1;
    80003b68:	4785                	li	a5,1
    80003b6a:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003b6c:	00019517          	auipc	a0,0x19
    80003b70:	32c50513          	addi	a0,a0,812 # 8001ce98 <ftable>
    80003b74:	00003097          	auipc	ra,0x3
    80003b78:	bbc080e7          	jalr	-1092(ra) # 80006730 <release>
}
    80003b7c:	8526                	mv	a0,s1
    80003b7e:	60e2                	ld	ra,24(sp)
    80003b80:	6442                	ld	s0,16(sp)
    80003b82:	64a2                	ld	s1,8(sp)
    80003b84:	6105                	addi	sp,sp,32
    80003b86:	8082                	ret

0000000080003b88 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80003b88:	1101                	addi	sp,sp,-32
    80003b8a:	ec06                	sd	ra,24(sp)
    80003b8c:	e822                	sd	s0,16(sp)
    80003b8e:	e426                	sd	s1,8(sp)
    80003b90:	1000                	addi	s0,sp,32
    80003b92:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80003b94:	00019517          	auipc	a0,0x19
    80003b98:	30450513          	addi	a0,a0,772 # 8001ce98 <ftable>
    80003b9c:	00003097          	auipc	ra,0x3
    80003ba0:	ac4080e7          	jalr	-1340(ra) # 80006660 <acquire>
  if(f->ref < 1)
    80003ba4:	40dc                	lw	a5,4(s1)
    80003ba6:	02f05263          	blez	a5,80003bca <filedup+0x42>
    panic("filedup");
  f->ref++;
    80003baa:	2785                	addiw	a5,a5,1
    80003bac:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80003bae:	00019517          	auipc	a0,0x19
    80003bb2:	2ea50513          	addi	a0,a0,746 # 8001ce98 <ftable>
    80003bb6:	00003097          	auipc	ra,0x3
    80003bba:	b7a080e7          	jalr	-1158(ra) # 80006730 <release>
  return f;
}
    80003bbe:	8526                	mv	a0,s1
    80003bc0:	60e2                	ld	ra,24(sp)
    80003bc2:	6442                	ld	s0,16(sp)
    80003bc4:	64a2                	ld	s1,8(sp)
    80003bc6:	6105                	addi	sp,sp,32
    80003bc8:	8082                	ret
    panic("filedup");
    80003bca:	00005517          	auipc	a0,0x5
    80003bce:	a3e50513          	addi	a0,a0,-1474 # 80008608 <syscalls+0x240>
    80003bd2:	00002097          	auipc	ra,0x2
    80003bd6:	55a080e7          	jalr	1370(ra) # 8000612c <panic>

0000000080003bda <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80003bda:	7139                	addi	sp,sp,-64
    80003bdc:	fc06                	sd	ra,56(sp)
    80003bde:	f822                	sd	s0,48(sp)
    80003be0:	f426                	sd	s1,40(sp)
    80003be2:	f04a                	sd	s2,32(sp)
    80003be4:	ec4e                	sd	s3,24(sp)
    80003be6:	e852                	sd	s4,16(sp)
    80003be8:	e456                	sd	s5,8(sp)
    80003bea:	0080                	addi	s0,sp,64
    80003bec:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80003bee:	00019517          	auipc	a0,0x19
    80003bf2:	2aa50513          	addi	a0,a0,682 # 8001ce98 <ftable>
    80003bf6:	00003097          	auipc	ra,0x3
    80003bfa:	a6a080e7          	jalr	-1430(ra) # 80006660 <acquire>
  if(f->ref < 1)
    80003bfe:	40dc                	lw	a5,4(s1)
    80003c00:	06f05163          	blez	a5,80003c62 <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    80003c04:	37fd                	addiw	a5,a5,-1
    80003c06:	0007871b          	sext.w	a4,a5
    80003c0a:	c0dc                	sw	a5,4(s1)
    80003c0c:	06e04363          	bgtz	a4,80003c72 <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003c10:	0004a903          	lw	s2,0(s1)
    80003c14:	0094ca83          	lbu	s5,9(s1)
    80003c18:	0104ba03          	ld	s4,16(s1)
    80003c1c:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003c20:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80003c24:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003c28:	00019517          	auipc	a0,0x19
    80003c2c:	27050513          	addi	a0,a0,624 # 8001ce98 <ftable>
    80003c30:	00003097          	auipc	ra,0x3
    80003c34:	b00080e7          	jalr	-1280(ra) # 80006730 <release>

  if(ff.type == FD_PIPE){
    80003c38:	4785                	li	a5,1
    80003c3a:	04f90d63          	beq	s2,a5,80003c94 <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003c3e:	3979                	addiw	s2,s2,-2
    80003c40:	4785                	li	a5,1
    80003c42:	0527e063          	bltu	a5,s2,80003c82 <fileclose+0xa8>
    begin_op();
    80003c46:	00000097          	auipc	ra,0x0
    80003c4a:	ac8080e7          	jalr	-1336(ra) # 8000370e <begin_op>
    iput(ff.ip);
    80003c4e:	854e                	mv	a0,s3
    80003c50:	fffff097          	auipc	ra,0xfffff
    80003c54:	2a6080e7          	jalr	678(ra) # 80002ef6 <iput>
    end_op();
    80003c58:	00000097          	auipc	ra,0x0
    80003c5c:	b36080e7          	jalr	-1226(ra) # 8000378e <end_op>
    80003c60:	a00d                	j	80003c82 <fileclose+0xa8>
    panic("fileclose");
    80003c62:	00005517          	auipc	a0,0x5
    80003c66:	9ae50513          	addi	a0,a0,-1618 # 80008610 <syscalls+0x248>
    80003c6a:	00002097          	auipc	ra,0x2
    80003c6e:	4c2080e7          	jalr	1218(ra) # 8000612c <panic>
    release(&ftable.lock);
    80003c72:	00019517          	auipc	a0,0x19
    80003c76:	22650513          	addi	a0,a0,550 # 8001ce98 <ftable>
    80003c7a:	00003097          	auipc	ra,0x3
    80003c7e:	ab6080e7          	jalr	-1354(ra) # 80006730 <release>
  }
}
    80003c82:	70e2                	ld	ra,56(sp)
    80003c84:	7442                	ld	s0,48(sp)
    80003c86:	74a2                	ld	s1,40(sp)
    80003c88:	7902                	ld	s2,32(sp)
    80003c8a:	69e2                	ld	s3,24(sp)
    80003c8c:	6a42                	ld	s4,16(sp)
    80003c8e:	6aa2                	ld	s5,8(sp)
    80003c90:	6121                	addi	sp,sp,64
    80003c92:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003c94:	85d6                	mv	a1,s5
    80003c96:	8552                	mv	a0,s4
    80003c98:	00000097          	auipc	ra,0x0
    80003c9c:	34c080e7          	jalr	844(ra) # 80003fe4 <pipeclose>
    80003ca0:	b7cd                	j	80003c82 <fileclose+0xa8>

0000000080003ca2 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003ca2:	715d                	addi	sp,sp,-80
    80003ca4:	e486                	sd	ra,72(sp)
    80003ca6:	e0a2                	sd	s0,64(sp)
    80003ca8:	fc26                	sd	s1,56(sp)
    80003caa:	f84a                	sd	s2,48(sp)
    80003cac:	f44e                	sd	s3,40(sp)
    80003cae:	0880                	addi	s0,sp,80
    80003cb0:	84aa                	mv	s1,a0
    80003cb2:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80003cb4:	ffffd097          	auipc	ra,0xffffd
    80003cb8:	282080e7          	jalr	642(ra) # 80000f36 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003cbc:	409c                	lw	a5,0(s1)
    80003cbe:	37f9                	addiw	a5,a5,-2
    80003cc0:	4705                	li	a4,1
    80003cc2:	04f76763          	bltu	a4,a5,80003d10 <filestat+0x6e>
    80003cc6:	892a                	mv	s2,a0
    ilock(f->ip);
    80003cc8:	6c88                	ld	a0,24(s1)
    80003cca:	fffff097          	auipc	ra,0xfffff
    80003cce:	072080e7          	jalr	114(ra) # 80002d3c <ilock>
    stati(f->ip, &st);
    80003cd2:	fb840593          	addi	a1,s0,-72
    80003cd6:	6c88                	ld	a0,24(s1)
    80003cd8:	fffff097          	auipc	ra,0xfffff
    80003cdc:	2ee080e7          	jalr	750(ra) # 80002fc6 <stati>
    iunlock(f->ip);
    80003ce0:	6c88                	ld	a0,24(s1)
    80003ce2:	fffff097          	auipc	ra,0xfffff
    80003ce6:	11c080e7          	jalr	284(ra) # 80002dfe <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003cea:	46e1                	li	a3,24
    80003cec:	fb840613          	addi	a2,s0,-72
    80003cf0:	85ce                	mv	a1,s3
    80003cf2:	05893503          	ld	a0,88(s2)
    80003cf6:	ffffd097          	auipc	ra,0xffffd
    80003cfa:	f02080e7          	jalr	-254(ra) # 80000bf8 <copyout>
    80003cfe:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80003d02:	60a6                	ld	ra,72(sp)
    80003d04:	6406                	ld	s0,64(sp)
    80003d06:	74e2                	ld	s1,56(sp)
    80003d08:	7942                	ld	s2,48(sp)
    80003d0a:	79a2                	ld	s3,40(sp)
    80003d0c:	6161                	addi	sp,sp,80
    80003d0e:	8082                	ret
  return -1;
    80003d10:	557d                	li	a0,-1
    80003d12:	bfc5                	j	80003d02 <filestat+0x60>

0000000080003d14 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003d14:	7179                	addi	sp,sp,-48
    80003d16:	f406                	sd	ra,40(sp)
    80003d18:	f022                	sd	s0,32(sp)
    80003d1a:	ec26                	sd	s1,24(sp)
    80003d1c:	e84a                	sd	s2,16(sp)
    80003d1e:	e44e                	sd	s3,8(sp)
    80003d20:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003d22:	00854783          	lbu	a5,8(a0)
    80003d26:	c3d5                	beqz	a5,80003dca <fileread+0xb6>
    80003d28:	84aa                	mv	s1,a0
    80003d2a:	89ae                	mv	s3,a1
    80003d2c:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80003d2e:	411c                	lw	a5,0(a0)
    80003d30:	4705                	li	a4,1
    80003d32:	04e78963          	beq	a5,a4,80003d84 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003d36:	470d                	li	a4,3
    80003d38:	04e78d63          	beq	a5,a4,80003d92 <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80003d3c:	4709                	li	a4,2
    80003d3e:	06e79e63          	bne	a5,a4,80003dba <fileread+0xa6>
    ilock(f->ip);
    80003d42:	6d08                	ld	a0,24(a0)
    80003d44:	fffff097          	auipc	ra,0xfffff
    80003d48:	ff8080e7          	jalr	-8(ra) # 80002d3c <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003d4c:	874a                	mv	a4,s2
    80003d4e:	5094                	lw	a3,32(s1)
    80003d50:	864e                	mv	a2,s3
    80003d52:	4585                	li	a1,1
    80003d54:	6c88                	ld	a0,24(s1)
    80003d56:	fffff097          	auipc	ra,0xfffff
    80003d5a:	29a080e7          	jalr	666(ra) # 80002ff0 <readi>
    80003d5e:	892a                	mv	s2,a0
    80003d60:	00a05563          	blez	a0,80003d6a <fileread+0x56>
      f->off += r;
    80003d64:	509c                	lw	a5,32(s1)
    80003d66:	9fa9                	addw	a5,a5,a0
    80003d68:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003d6a:	6c88                	ld	a0,24(s1)
    80003d6c:	fffff097          	auipc	ra,0xfffff
    80003d70:	092080e7          	jalr	146(ra) # 80002dfe <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80003d74:	854a                	mv	a0,s2
    80003d76:	70a2                	ld	ra,40(sp)
    80003d78:	7402                	ld	s0,32(sp)
    80003d7a:	64e2                	ld	s1,24(sp)
    80003d7c:	6942                	ld	s2,16(sp)
    80003d7e:	69a2                	ld	s3,8(sp)
    80003d80:	6145                	addi	sp,sp,48
    80003d82:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80003d84:	6908                	ld	a0,16(a0)
    80003d86:	00000097          	auipc	ra,0x0
    80003d8a:	3d2080e7          	jalr	978(ra) # 80004158 <piperead>
    80003d8e:	892a                	mv	s2,a0
    80003d90:	b7d5                	j	80003d74 <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003d92:	02451783          	lh	a5,36(a0)
    80003d96:	03079693          	slli	a3,a5,0x30
    80003d9a:	92c1                	srli	a3,a3,0x30
    80003d9c:	4725                	li	a4,9
    80003d9e:	02d76863          	bltu	a4,a3,80003dce <fileread+0xba>
    80003da2:	0792                	slli	a5,a5,0x4
    80003da4:	00019717          	auipc	a4,0x19
    80003da8:	05470713          	addi	a4,a4,84 # 8001cdf8 <devsw>
    80003dac:	97ba                	add	a5,a5,a4
    80003dae:	639c                	ld	a5,0(a5)
    80003db0:	c38d                	beqz	a5,80003dd2 <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80003db2:	4505                	li	a0,1
    80003db4:	9782                	jalr	a5
    80003db6:	892a                	mv	s2,a0
    80003db8:	bf75                	j	80003d74 <fileread+0x60>
    panic("fileread");
    80003dba:	00005517          	auipc	a0,0x5
    80003dbe:	86650513          	addi	a0,a0,-1946 # 80008620 <syscalls+0x258>
    80003dc2:	00002097          	auipc	ra,0x2
    80003dc6:	36a080e7          	jalr	874(ra) # 8000612c <panic>
    return -1;
    80003dca:	597d                	li	s2,-1
    80003dcc:	b765                	j	80003d74 <fileread+0x60>
      return -1;
    80003dce:	597d                	li	s2,-1
    80003dd0:	b755                	j	80003d74 <fileread+0x60>
    80003dd2:	597d                	li	s2,-1
    80003dd4:	b745                	j	80003d74 <fileread+0x60>

0000000080003dd6 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80003dd6:	715d                	addi	sp,sp,-80
    80003dd8:	e486                	sd	ra,72(sp)
    80003dda:	e0a2                	sd	s0,64(sp)
    80003ddc:	fc26                	sd	s1,56(sp)
    80003dde:	f84a                	sd	s2,48(sp)
    80003de0:	f44e                	sd	s3,40(sp)
    80003de2:	f052                	sd	s4,32(sp)
    80003de4:	ec56                	sd	s5,24(sp)
    80003de6:	e85a                	sd	s6,16(sp)
    80003de8:	e45e                	sd	s7,8(sp)
    80003dea:	e062                	sd	s8,0(sp)
    80003dec:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if(f->writable == 0)
    80003dee:	00954783          	lbu	a5,9(a0)
    80003df2:	10078663          	beqz	a5,80003efe <filewrite+0x128>
    80003df6:	892a                	mv	s2,a0
    80003df8:	8aae                	mv	s5,a1
    80003dfa:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    80003dfc:	411c                	lw	a5,0(a0)
    80003dfe:	4705                	li	a4,1
    80003e00:	02e78263          	beq	a5,a4,80003e24 <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003e04:	470d                	li	a4,3
    80003e06:	02e78663          	beq	a5,a4,80003e32 <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80003e0a:	4709                	li	a4,2
    80003e0c:	0ee79163          	bne	a5,a4,80003eee <filewrite+0x118>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80003e10:	0ac05d63          	blez	a2,80003eca <filewrite+0xf4>
    int i = 0;
    80003e14:	4981                	li	s3,0
    80003e16:	6b05                	lui	s6,0x1
    80003e18:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    80003e1c:	6b85                	lui	s7,0x1
    80003e1e:	c00b8b9b          	addiw	s7,s7,-1024
    80003e22:	a861                	j	80003eba <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    80003e24:	6908                	ld	a0,16(a0)
    80003e26:	00000097          	auipc	ra,0x0
    80003e2a:	238080e7          	jalr	568(ra) # 8000405e <pipewrite>
    80003e2e:	8a2a                	mv	s4,a0
    80003e30:	a045                	j	80003ed0 <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003e32:	02451783          	lh	a5,36(a0)
    80003e36:	03079693          	slli	a3,a5,0x30
    80003e3a:	92c1                	srli	a3,a3,0x30
    80003e3c:	4725                	li	a4,9
    80003e3e:	0cd76263          	bltu	a4,a3,80003f02 <filewrite+0x12c>
    80003e42:	0792                	slli	a5,a5,0x4
    80003e44:	00019717          	auipc	a4,0x19
    80003e48:	fb470713          	addi	a4,a4,-76 # 8001cdf8 <devsw>
    80003e4c:	97ba                	add	a5,a5,a4
    80003e4e:	679c                	ld	a5,8(a5)
    80003e50:	cbdd                	beqz	a5,80003f06 <filewrite+0x130>
    ret = devsw[f->major].write(1, addr, n);
    80003e52:	4505                	li	a0,1
    80003e54:	9782                	jalr	a5
    80003e56:	8a2a                	mv	s4,a0
    80003e58:	a8a5                	j	80003ed0 <filewrite+0xfa>
    80003e5a:	00048c1b          	sext.w	s8,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    80003e5e:	00000097          	auipc	ra,0x0
    80003e62:	8b0080e7          	jalr	-1872(ra) # 8000370e <begin_op>
      ilock(f->ip);
    80003e66:	01893503          	ld	a0,24(s2)
    80003e6a:	fffff097          	auipc	ra,0xfffff
    80003e6e:	ed2080e7          	jalr	-302(ra) # 80002d3c <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003e72:	8762                	mv	a4,s8
    80003e74:	02092683          	lw	a3,32(s2)
    80003e78:	01598633          	add	a2,s3,s5
    80003e7c:	4585                	li	a1,1
    80003e7e:	01893503          	ld	a0,24(s2)
    80003e82:	fffff097          	auipc	ra,0xfffff
    80003e86:	266080e7          	jalr	614(ra) # 800030e8 <writei>
    80003e8a:	84aa                	mv	s1,a0
    80003e8c:	00a05763          	blez	a0,80003e9a <filewrite+0xc4>
        f->off += r;
    80003e90:	02092783          	lw	a5,32(s2)
    80003e94:	9fa9                	addw	a5,a5,a0
    80003e96:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80003e9a:	01893503          	ld	a0,24(s2)
    80003e9e:	fffff097          	auipc	ra,0xfffff
    80003ea2:	f60080e7          	jalr	-160(ra) # 80002dfe <iunlock>
      end_op();
    80003ea6:	00000097          	auipc	ra,0x0
    80003eaa:	8e8080e7          	jalr	-1816(ra) # 8000378e <end_op>

      if(r != n1){
    80003eae:	009c1f63          	bne	s8,s1,80003ecc <filewrite+0xf6>
        // error from writei
        break;
      }
      i += r;
    80003eb2:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80003eb6:	0149db63          	bge	s3,s4,80003ecc <filewrite+0xf6>
      int n1 = n - i;
    80003eba:	413a07bb          	subw	a5,s4,s3
      if(n1 > max)
    80003ebe:	84be                	mv	s1,a5
    80003ec0:	2781                	sext.w	a5,a5
    80003ec2:	f8fb5ce3          	bge	s6,a5,80003e5a <filewrite+0x84>
    80003ec6:	84de                	mv	s1,s7
    80003ec8:	bf49                	j	80003e5a <filewrite+0x84>
    int i = 0;
    80003eca:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    80003ecc:	013a1f63          	bne	s4,s3,80003eea <filewrite+0x114>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80003ed0:	8552                	mv	a0,s4
    80003ed2:	60a6                	ld	ra,72(sp)
    80003ed4:	6406                	ld	s0,64(sp)
    80003ed6:	74e2                	ld	s1,56(sp)
    80003ed8:	7942                	ld	s2,48(sp)
    80003eda:	79a2                	ld	s3,40(sp)
    80003edc:	7a02                	ld	s4,32(sp)
    80003ede:	6ae2                	ld	s5,24(sp)
    80003ee0:	6b42                	ld	s6,16(sp)
    80003ee2:	6ba2                	ld	s7,8(sp)
    80003ee4:	6c02                	ld	s8,0(sp)
    80003ee6:	6161                	addi	sp,sp,80
    80003ee8:	8082                	ret
    ret = (i == n ? n : -1);
    80003eea:	5a7d                	li	s4,-1
    80003eec:	b7d5                	j	80003ed0 <filewrite+0xfa>
    panic("filewrite");
    80003eee:	00004517          	auipc	a0,0x4
    80003ef2:	74250513          	addi	a0,a0,1858 # 80008630 <syscalls+0x268>
    80003ef6:	00002097          	auipc	ra,0x2
    80003efa:	236080e7          	jalr	566(ra) # 8000612c <panic>
    return -1;
    80003efe:	5a7d                	li	s4,-1
    80003f00:	bfc1                	j	80003ed0 <filewrite+0xfa>
      return -1;
    80003f02:	5a7d                	li	s4,-1
    80003f04:	b7f1                	j	80003ed0 <filewrite+0xfa>
    80003f06:	5a7d                	li	s4,-1
    80003f08:	b7e1                	j	80003ed0 <filewrite+0xfa>

0000000080003f0a <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80003f0a:	7179                	addi	sp,sp,-48
    80003f0c:	f406                	sd	ra,40(sp)
    80003f0e:	f022                	sd	s0,32(sp)
    80003f10:	ec26                	sd	s1,24(sp)
    80003f12:	e84a                	sd	s2,16(sp)
    80003f14:	e44e                	sd	s3,8(sp)
    80003f16:	e052                	sd	s4,0(sp)
    80003f18:	1800                	addi	s0,sp,48
    80003f1a:	84aa                	mv	s1,a0
    80003f1c:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003f1e:	0005b023          	sd	zero,0(a1)
    80003f22:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003f26:	00000097          	auipc	ra,0x0
    80003f2a:	bf8080e7          	jalr	-1032(ra) # 80003b1e <filealloc>
    80003f2e:	e088                	sd	a0,0(s1)
    80003f30:	c551                	beqz	a0,80003fbc <pipealloc+0xb2>
    80003f32:	00000097          	auipc	ra,0x0
    80003f36:	bec080e7          	jalr	-1044(ra) # 80003b1e <filealloc>
    80003f3a:	00aa3023          	sd	a0,0(s4)
    80003f3e:	c92d                	beqz	a0,80003fb0 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003f40:	ffffc097          	auipc	ra,0xffffc
    80003f44:	22c080e7          	jalr	556(ra) # 8000016c <kalloc>
    80003f48:	892a                	mv	s2,a0
    80003f4a:	c125                	beqz	a0,80003faa <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80003f4c:	4985                	li	s3,1
    80003f4e:	23352423          	sw	s3,552(a0)
  pi->writeopen = 1;
    80003f52:	23352623          	sw	s3,556(a0)
  pi->nwrite = 0;
    80003f56:	22052223          	sw	zero,548(a0)
  pi->nread = 0;
    80003f5a:	22052023          	sw	zero,544(a0)
  initlock(&pi->lock, "pipe");
    80003f5e:	00004597          	auipc	a1,0x4
    80003f62:	6e258593          	addi	a1,a1,1762 # 80008640 <syscalls+0x278>
    80003f66:	00003097          	auipc	ra,0x3
    80003f6a:	876080e7          	jalr	-1930(ra) # 800067dc <initlock>
  (*f0)->type = FD_PIPE;
    80003f6e:	609c                	ld	a5,0(s1)
    80003f70:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80003f74:	609c                	ld	a5,0(s1)
    80003f76:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80003f7a:	609c                	ld	a5,0(s1)
    80003f7c:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003f80:	609c                	ld	a5,0(s1)
    80003f82:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80003f86:	000a3783          	ld	a5,0(s4)
    80003f8a:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003f8e:	000a3783          	ld	a5,0(s4)
    80003f92:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80003f96:	000a3783          	ld	a5,0(s4)
    80003f9a:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003f9e:	000a3783          	ld	a5,0(s4)
    80003fa2:	0127b823          	sd	s2,16(a5)
  return 0;
    80003fa6:	4501                	li	a0,0
    80003fa8:	a025                	j	80003fd0 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80003faa:	6088                	ld	a0,0(s1)
    80003fac:	e501                	bnez	a0,80003fb4 <pipealloc+0xaa>
    80003fae:	a039                	j	80003fbc <pipealloc+0xb2>
    80003fb0:	6088                	ld	a0,0(s1)
    80003fb2:	c51d                	beqz	a0,80003fe0 <pipealloc+0xd6>
    fileclose(*f0);
    80003fb4:	00000097          	auipc	ra,0x0
    80003fb8:	c26080e7          	jalr	-986(ra) # 80003bda <fileclose>
  if(*f1)
    80003fbc:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80003fc0:	557d                	li	a0,-1
  if(*f1)
    80003fc2:	c799                	beqz	a5,80003fd0 <pipealloc+0xc6>
    fileclose(*f1);
    80003fc4:	853e                	mv	a0,a5
    80003fc6:	00000097          	auipc	ra,0x0
    80003fca:	c14080e7          	jalr	-1004(ra) # 80003bda <fileclose>
  return -1;
    80003fce:	557d                	li	a0,-1
}
    80003fd0:	70a2                	ld	ra,40(sp)
    80003fd2:	7402                	ld	s0,32(sp)
    80003fd4:	64e2                	ld	s1,24(sp)
    80003fd6:	6942                	ld	s2,16(sp)
    80003fd8:	69a2                	ld	s3,8(sp)
    80003fda:	6a02                	ld	s4,0(sp)
    80003fdc:	6145                	addi	sp,sp,48
    80003fde:	8082                	ret
  return -1;
    80003fe0:	557d                	li	a0,-1
    80003fe2:	b7fd                	j	80003fd0 <pipealloc+0xc6>

0000000080003fe4 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80003fe4:	1101                	addi	sp,sp,-32
    80003fe6:	ec06                	sd	ra,24(sp)
    80003fe8:	e822                	sd	s0,16(sp)
    80003fea:	e426                	sd	s1,8(sp)
    80003fec:	e04a                	sd	s2,0(sp)
    80003fee:	1000                	addi	s0,sp,32
    80003ff0:	84aa                	mv	s1,a0
    80003ff2:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80003ff4:	00002097          	auipc	ra,0x2
    80003ff8:	66c080e7          	jalr	1644(ra) # 80006660 <acquire>
  if(writable){
    80003ffc:	04090263          	beqz	s2,80004040 <pipeclose+0x5c>
    pi->writeopen = 0;
    80004000:	2204a623          	sw	zero,556(s1)
    wakeup(&pi->nread);
    80004004:	22048513          	addi	a0,s1,544
    80004008:	ffffd097          	auipc	ra,0xffffd
    8000400c:	776080e7          	jalr	1910(ra) # 8000177e <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80004010:	2284b783          	ld	a5,552(s1)
    80004014:	ef9d                	bnez	a5,80004052 <pipeclose+0x6e>
    release(&pi->lock);
    80004016:	8526                	mv	a0,s1
    80004018:	00002097          	auipc	ra,0x2
    8000401c:	718080e7          	jalr	1816(ra) # 80006730 <release>
#ifdef LAB_LOCK
    freelock(&pi->lock);
    80004020:	8526                	mv	a0,s1
    80004022:	00002097          	auipc	ra,0x2
    80004026:	756080e7          	jalr	1878(ra) # 80006778 <freelock>
#endif    
    kfree((char*)pi);
    8000402a:	8526                	mv	a0,s1
    8000402c:	ffffc097          	auipc	ra,0xffffc
    80004030:	ff0080e7          	jalr	-16(ra) # 8000001c <kfree>
  } else
    release(&pi->lock);
}
    80004034:	60e2                	ld	ra,24(sp)
    80004036:	6442                	ld	s0,16(sp)
    80004038:	64a2                	ld	s1,8(sp)
    8000403a:	6902                	ld	s2,0(sp)
    8000403c:	6105                	addi	sp,sp,32
    8000403e:	8082                	ret
    pi->readopen = 0;
    80004040:	2204a423          	sw	zero,552(s1)
    wakeup(&pi->nwrite);
    80004044:	22448513          	addi	a0,s1,548
    80004048:	ffffd097          	auipc	ra,0xffffd
    8000404c:	736080e7          	jalr	1846(ra) # 8000177e <wakeup>
    80004050:	b7c1                	j	80004010 <pipeclose+0x2c>
    release(&pi->lock);
    80004052:	8526                	mv	a0,s1
    80004054:	00002097          	auipc	ra,0x2
    80004058:	6dc080e7          	jalr	1756(ra) # 80006730 <release>
}
    8000405c:	bfe1                	j	80004034 <pipeclose+0x50>

000000008000405e <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    8000405e:	7159                	addi	sp,sp,-112
    80004060:	f486                	sd	ra,104(sp)
    80004062:	f0a2                	sd	s0,96(sp)
    80004064:	eca6                	sd	s1,88(sp)
    80004066:	e8ca                	sd	s2,80(sp)
    80004068:	e4ce                	sd	s3,72(sp)
    8000406a:	e0d2                	sd	s4,64(sp)
    8000406c:	fc56                	sd	s5,56(sp)
    8000406e:	f85a                	sd	s6,48(sp)
    80004070:	f45e                	sd	s7,40(sp)
    80004072:	f062                	sd	s8,32(sp)
    80004074:	ec66                	sd	s9,24(sp)
    80004076:	1880                	addi	s0,sp,112
    80004078:	84aa                	mv	s1,a0
    8000407a:	8aae                	mv	s5,a1
    8000407c:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    8000407e:	ffffd097          	auipc	ra,0xffffd
    80004082:	eb8080e7          	jalr	-328(ra) # 80000f36 <myproc>
    80004086:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80004088:	8526                	mv	a0,s1
    8000408a:	00002097          	auipc	ra,0x2
    8000408e:	5d6080e7          	jalr	1494(ra) # 80006660 <acquire>
  while(i < n){
    80004092:	0d405163          	blez	s4,80004154 <pipewrite+0xf6>
    80004096:	8ba6                	mv	s7,s1
  int i = 0;
    80004098:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    8000409a:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    8000409c:	22048c93          	addi	s9,s1,544
      sleep(&pi->nwrite, &pi->lock);
    800040a0:	22448c13          	addi	s8,s1,548
    800040a4:	a08d                	j	80004106 <pipewrite+0xa8>
      release(&pi->lock);
    800040a6:	8526                	mv	a0,s1
    800040a8:	00002097          	auipc	ra,0x2
    800040ac:	688080e7          	jalr	1672(ra) # 80006730 <release>
      return -1;
    800040b0:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    800040b2:	854a                	mv	a0,s2
    800040b4:	70a6                	ld	ra,104(sp)
    800040b6:	7406                	ld	s0,96(sp)
    800040b8:	64e6                	ld	s1,88(sp)
    800040ba:	6946                	ld	s2,80(sp)
    800040bc:	69a6                	ld	s3,72(sp)
    800040be:	6a06                	ld	s4,64(sp)
    800040c0:	7ae2                	ld	s5,56(sp)
    800040c2:	7b42                	ld	s6,48(sp)
    800040c4:	7ba2                	ld	s7,40(sp)
    800040c6:	7c02                	ld	s8,32(sp)
    800040c8:	6ce2                	ld	s9,24(sp)
    800040ca:	6165                	addi	sp,sp,112
    800040cc:	8082                	ret
      wakeup(&pi->nread);
    800040ce:	8566                	mv	a0,s9
    800040d0:	ffffd097          	auipc	ra,0xffffd
    800040d4:	6ae080e7          	jalr	1710(ra) # 8000177e <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    800040d8:	85de                	mv	a1,s7
    800040da:	8562                	mv	a0,s8
    800040dc:	ffffd097          	auipc	ra,0xffffd
    800040e0:	516080e7          	jalr	1302(ra) # 800015f2 <sleep>
    800040e4:	a839                	j	80004102 <pipewrite+0xa4>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    800040e6:	2244a783          	lw	a5,548(s1)
    800040ea:	0017871b          	addiw	a4,a5,1
    800040ee:	22e4a223          	sw	a4,548(s1)
    800040f2:	1ff7f793          	andi	a5,a5,511
    800040f6:	97a6                	add	a5,a5,s1
    800040f8:	f9f44703          	lbu	a4,-97(s0)
    800040fc:	02e78023          	sb	a4,32(a5)
      i++;
    80004100:	2905                	addiw	s2,s2,1
  while(i < n){
    80004102:	03495d63          	bge	s2,s4,8000413c <pipewrite+0xde>
    if(pi->readopen == 0 || pr->killed){
    80004106:	2284a783          	lw	a5,552(s1)
    8000410a:	dfd1                	beqz	a5,800040a6 <pipewrite+0x48>
    8000410c:	0309a783          	lw	a5,48(s3)
    80004110:	fbd9                	bnez	a5,800040a6 <pipewrite+0x48>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80004112:	2204a783          	lw	a5,544(s1)
    80004116:	2244a703          	lw	a4,548(s1)
    8000411a:	2007879b          	addiw	a5,a5,512
    8000411e:	faf708e3          	beq	a4,a5,800040ce <pipewrite+0x70>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004122:	4685                	li	a3,1
    80004124:	01590633          	add	a2,s2,s5
    80004128:	f9f40593          	addi	a1,s0,-97
    8000412c:	0589b503          	ld	a0,88(s3)
    80004130:	ffffd097          	auipc	ra,0xffffd
    80004134:	b54080e7          	jalr	-1196(ra) # 80000c84 <copyin>
    80004138:	fb6517e3          	bne	a0,s6,800040e6 <pipewrite+0x88>
  wakeup(&pi->nread);
    8000413c:	22048513          	addi	a0,s1,544
    80004140:	ffffd097          	auipc	ra,0xffffd
    80004144:	63e080e7          	jalr	1598(ra) # 8000177e <wakeup>
  release(&pi->lock);
    80004148:	8526                	mv	a0,s1
    8000414a:	00002097          	auipc	ra,0x2
    8000414e:	5e6080e7          	jalr	1510(ra) # 80006730 <release>
  return i;
    80004152:	b785                	j	800040b2 <pipewrite+0x54>
  int i = 0;
    80004154:	4901                	li	s2,0
    80004156:	b7dd                	j	8000413c <pipewrite+0xde>

0000000080004158 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80004158:	715d                	addi	sp,sp,-80
    8000415a:	e486                	sd	ra,72(sp)
    8000415c:	e0a2                	sd	s0,64(sp)
    8000415e:	fc26                	sd	s1,56(sp)
    80004160:	f84a                	sd	s2,48(sp)
    80004162:	f44e                	sd	s3,40(sp)
    80004164:	f052                	sd	s4,32(sp)
    80004166:	ec56                	sd	s5,24(sp)
    80004168:	e85a                	sd	s6,16(sp)
    8000416a:	0880                	addi	s0,sp,80
    8000416c:	84aa                	mv	s1,a0
    8000416e:	892e                	mv	s2,a1
    80004170:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80004172:	ffffd097          	auipc	ra,0xffffd
    80004176:	dc4080e7          	jalr	-572(ra) # 80000f36 <myproc>
    8000417a:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    8000417c:	8b26                	mv	s6,s1
    8000417e:	8526                	mv	a0,s1
    80004180:	00002097          	auipc	ra,0x2
    80004184:	4e0080e7          	jalr	1248(ra) # 80006660 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004188:	2204a703          	lw	a4,544(s1)
    8000418c:	2244a783          	lw	a5,548(s1)
    if(pr->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004190:	22048993          	addi	s3,s1,544
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004194:	02f71463          	bne	a4,a5,800041bc <piperead+0x64>
    80004198:	22c4a783          	lw	a5,556(s1)
    8000419c:	c385                	beqz	a5,800041bc <piperead+0x64>
    if(pr->killed){
    8000419e:	030a2783          	lw	a5,48(s4)
    800041a2:	ebc1                	bnez	a5,80004232 <piperead+0xda>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800041a4:	85da                	mv	a1,s6
    800041a6:	854e                	mv	a0,s3
    800041a8:	ffffd097          	auipc	ra,0xffffd
    800041ac:	44a080e7          	jalr	1098(ra) # 800015f2 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800041b0:	2204a703          	lw	a4,544(s1)
    800041b4:	2244a783          	lw	a5,548(s1)
    800041b8:	fef700e3          	beq	a4,a5,80004198 <piperead+0x40>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800041bc:	09505263          	blez	s5,80004240 <piperead+0xe8>
    800041c0:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800041c2:	5b7d                	li	s6,-1
    if(pi->nread == pi->nwrite)
    800041c4:	2204a783          	lw	a5,544(s1)
    800041c8:	2244a703          	lw	a4,548(s1)
    800041cc:	02f70d63          	beq	a4,a5,80004206 <piperead+0xae>
    ch = pi->data[pi->nread++ % PIPESIZE];
    800041d0:	0017871b          	addiw	a4,a5,1
    800041d4:	22e4a023          	sw	a4,544(s1)
    800041d8:	1ff7f793          	andi	a5,a5,511
    800041dc:	97a6                	add	a5,a5,s1
    800041de:	0207c783          	lbu	a5,32(a5)
    800041e2:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800041e6:	4685                	li	a3,1
    800041e8:	fbf40613          	addi	a2,s0,-65
    800041ec:	85ca                	mv	a1,s2
    800041ee:	058a3503          	ld	a0,88(s4)
    800041f2:	ffffd097          	auipc	ra,0xffffd
    800041f6:	a06080e7          	jalr	-1530(ra) # 80000bf8 <copyout>
    800041fa:	01650663          	beq	a0,s6,80004206 <piperead+0xae>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800041fe:	2985                	addiw	s3,s3,1
    80004200:	0905                	addi	s2,s2,1
    80004202:	fd3a91e3          	bne	s5,s3,800041c4 <piperead+0x6c>
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80004206:	22448513          	addi	a0,s1,548
    8000420a:	ffffd097          	auipc	ra,0xffffd
    8000420e:	574080e7          	jalr	1396(ra) # 8000177e <wakeup>
  release(&pi->lock);
    80004212:	8526                	mv	a0,s1
    80004214:	00002097          	auipc	ra,0x2
    80004218:	51c080e7          	jalr	1308(ra) # 80006730 <release>
  return i;
}
    8000421c:	854e                	mv	a0,s3
    8000421e:	60a6                	ld	ra,72(sp)
    80004220:	6406                	ld	s0,64(sp)
    80004222:	74e2                	ld	s1,56(sp)
    80004224:	7942                	ld	s2,48(sp)
    80004226:	79a2                	ld	s3,40(sp)
    80004228:	7a02                	ld	s4,32(sp)
    8000422a:	6ae2                	ld	s5,24(sp)
    8000422c:	6b42                	ld	s6,16(sp)
    8000422e:	6161                	addi	sp,sp,80
    80004230:	8082                	ret
      release(&pi->lock);
    80004232:	8526                	mv	a0,s1
    80004234:	00002097          	auipc	ra,0x2
    80004238:	4fc080e7          	jalr	1276(ra) # 80006730 <release>
      return -1;
    8000423c:	59fd                	li	s3,-1
    8000423e:	bff9                	j	8000421c <piperead+0xc4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004240:	4981                	li	s3,0
    80004242:	b7d1                	j	80004206 <piperead+0xae>

0000000080004244 <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    80004244:	df010113          	addi	sp,sp,-528
    80004248:	20113423          	sd	ra,520(sp)
    8000424c:	20813023          	sd	s0,512(sp)
    80004250:	ffa6                	sd	s1,504(sp)
    80004252:	fbca                	sd	s2,496(sp)
    80004254:	f7ce                	sd	s3,488(sp)
    80004256:	f3d2                	sd	s4,480(sp)
    80004258:	efd6                	sd	s5,472(sp)
    8000425a:	ebda                	sd	s6,464(sp)
    8000425c:	e7de                	sd	s7,456(sp)
    8000425e:	e3e2                	sd	s8,448(sp)
    80004260:	ff66                	sd	s9,440(sp)
    80004262:	fb6a                	sd	s10,432(sp)
    80004264:	f76e                	sd	s11,424(sp)
    80004266:	0c00                	addi	s0,sp,528
    80004268:	84aa                	mv	s1,a0
    8000426a:	dea43c23          	sd	a0,-520(s0)
    8000426e:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80004272:	ffffd097          	auipc	ra,0xffffd
    80004276:	cc4080e7          	jalr	-828(ra) # 80000f36 <myproc>
    8000427a:	892a                	mv	s2,a0

  begin_op();
    8000427c:	fffff097          	auipc	ra,0xfffff
    80004280:	492080e7          	jalr	1170(ra) # 8000370e <begin_op>

  if((ip = namei(path)) == 0){
    80004284:	8526                	mv	a0,s1
    80004286:	fffff097          	auipc	ra,0xfffff
    8000428a:	26c080e7          	jalr	620(ra) # 800034f2 <namei>
    8000428e:	c92d                	beqz	a0,80004300 <exec+0xbc>
    80004290:	84aa                	mv	s1,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80004292:	fffff097          	auipc	ra,0xfffff
    80004296:	aaa080e7          	jalr	-1366(ra) # 80002d3c <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    8000429a:	04000713          	li	a4,64
    8000429e:	4681                	li	a3,0
    800042a0:	e5040613          	addi	a2,s0,-432
    800042a4:	4581                	li	a1,0
    800042a6:	8526                	mv	a0,s1
    800042a8:	fffff097          	auipc	ra,0xfffff
    800042ac:	d48080e7          	jalr	-696(ra) # 80002ff0 <readi>
    800042b0:	04000793          	li	a5,64
    800042b4:	00f51a63          	bne	a0,a5,800042c8 <exec+0x84>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    800042b8:	e5042703          	lw	a4,-432(s0)
    800042bc:	464c47b7          	lui	a5,0x464c4
    800042c0:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    800042c4:	04f70463          	beq	a4,a5,8000430c <exec+0xc8>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    800042c8:	8526                	mv	a0,s1
    800042ca:	fffff097          	auipc	ra,0xfffff
    800042ce:	cd4080e7          	jalr	-812(ra) # 80002f9e <iunlockput>
    end_op();
    800042d2:	fffff097          	auipc	ra,0xfffff
    800042d6:	4bc080e7          	jalr	1212(ra) # 8000378e <end_op>
  }
  return -1;
    800042da:	557d                	li	a0,-1
}
    800042dc:	20813083          	ld	ra,520(sp)
    800042e0:	20013403          	ld	s0,512(sp)
    800042e4:	74fe                	ld	s1,504(sp)
    800042e6:	795e                	ld	s2,496(sp)
    800042e8:	79be                	ld	s3,488(sp)
    800042ea:	7a1e                	ld	s4,480(sp)
    800042ec:	6afe                	ld	s5,472(sp)
    800042ee:	6b5e                	ld	s6,464(sp)
    800042f0:	6bbe                	ld	s7,456(sp)
    800042f2:	6c1e                	ld	s8,448(sp)
    800042f4:	7cfa                	ld	s9,440(sp)
    800042f6:	7d5a                	ld	s10,432(sp)
    800042f8:	7dba                	ld	s11,424(sp)
    800042fa:	21010113          	addi	sp,sp,528
    800042fe:	8082                	ret
    end_op();
    80004300:	fffff097          	auipc	ra,0xfffff
    80004304:	48e080e7          	jalr	1166(ra) # 8000378e <end_op>
    return -1;
    80004308:	557d                	li	a0,-1
    8000430a:	bfc9                	j	800042dc <exec+0x98>
  if((pagetable = proc_pagetable(p)) == 0)
    8000430c:	854a                	mv	a0,s2
    8000430e:	ffffd097          	auipc	ra,0xffffd
    80004312:	cec080e7          	jalr	-788(ra) # 80000ffa <proc_pagetable>
    80004316:	8baa                	mv	s7,a0
    80004318:	d945                	beqz	a0,800042c8 <exec+0x84>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000431a:	e7042983          	lw	s3,-400(s0)
    8000431e:	e8845783          	lhu	a5,-376(s0)
    80004322:	c7ad                	beqz	a5,8000438c <exec+0x148>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004324:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004326:	4b01                	li	s6,0
    if((ph.vaddr % PGSIZE) != 0)
    80004328:	6c85                	lui	s9,0x1
    8000432a:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    8000432e:	def43823          	sd	a5,-528(s0)
    80004332:	a42d                	j	8000455c <exec+0x318>
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    80004334:	00004517          	auipc	a0,0x4
    80004338:	31450513          	addi	a0,a0,788 # 80008648 <syscalls+0x280>
    8000433c:	00002097          	auipc	ra,0x2
    80004340:	df0080e7          	jalr	-528(ra) # 8000612c <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80004344:	8756                	mv	a4,s5
    80004346:	012d86bb          	addw	a3,s11,s2
    8000434a:	4581                	li	a1,0
    8000434c:	8526                	mv	a0,s1
    8000434e:	fffff097          	auipc	ra,0xfffff
    80004352:	ca2080e7          	jalr	-862(ra) # 80002ff0 <readi>
    80004356:	2501                	sext.w	a0,a0
    80004358:	1aaa9963          	bne	s5,a0,8000450a <exec+0x2c6>
  for(i = 0; i < sz; i += PGSIZE){
    8000435c:	6785                	lui	a5,0x1
    8000435e:	0127893b          	addw	s2,a5,s2
    80004362:	77fd                	lui	a5,0xfffff
    80004364:	01478a3b          	addw	s4,a5,s4
    80004368:	1f897163          	bgeu	s2,s8,8000454a <exec+0x306>
    pa = walkaddr(pagetable, va + i);
    8000436c:	02091593          	slli	a1,s2,0x20
    80004370:	9181                	srli	a1,a1,0x20
    80004372:	95ea                	add	a1,a1,s10
    80004374:	855e                	mv	a0,s7
    80004376:	ffffc097          	auipc	ra,0xffffc
    8000437a:	27e080e7          	jalr	638(ra) # 800005f4 <walkaddr>
    8000437e:	862a                	mv	a2,a0
    if(pa == 0)
    80004380:	d955                	beqz	a0,80004334 <exec+0xf0>
      n = PGSIZE;
    80004382:	8ae6                	mv	s5,s9
    if(sz - i < PGSIZE)
    80004384:	fd9a70e3          	bgeu	s4,s9,80004344 <exec+0x100>
      n = sz - i;
    80004388:	8ad2                	mv	s5,s4
    8000438a:	bf6d                	j	80004344 <exec+0x100>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    8000438c:	4901                	li	s2,0
  iunlockput(ip);
    8000438e:	8526                	mv	a0,s1
    80004390:	fffff097          	auipc	ra,0xfffff
    80004394:	c0e080e7          	jalr	-1010(ra) # 80002f9e <iunlockput>
  end_op();
    80004398:	fffff097          	auipc	ra,0xfffff
    8000439c:	3f6080e7          	jalr	1014(ra) # 8000378e <end_op>
  p = myproc();
    800043a0:	ffffd097          	auipc	ra,0xffffd
    800043a4:	b96080e7          	jalr	-1130(ra) # 80000f36 <myproc>
    800043a8:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    800043aa:	05053d03          	ld	s10,80(a0)
  sz = PGROUNDUP(sz);
    800043ae:	6785                	lui	a5,0x1
    800043b0:	17fd                	addi	a5,a5,-1
    800043b2:	993e                	add	s2,s2,a5
    800043b4:	757d                	lui	a0,0xfffff
    800043b6:	00a977b3          	and	a5,s2,a0
    800043ba:	e0f43423          	sd	a5,-504(s0)
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    800043be:	6609                	lui	a2,0x2
    800043c0:	963e                	add	a2,a2,a5
    800043c2:	85be                	mv	a1,a5
    800043c4:	855e                	mv	a0,s7
    800043c6:	ffffc097          	auipc	ra,0xffffc
    800043ca:	5e2080e7          	jalr	1506(ra) # 800009a8 <uvmalloc>
    800043ce:	8b2a                	mv	s6,a0
  ip = 0;
    800043d0:	4481                	li	s1,0
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    800043d2:	12050c63          	beqz	a0,8000450a <exec+0x2c6>
  uvmclear(pagetable, sz-2*PGSIZE);
    800043d6:	75f9                	lui	a1,0xffffe
    800043d8:	95aa                	add	a1,a1,a0
    800043da:	855e                	mv	a0,s7
    800043dc:	ffffc097          	auipc	ra,0xffffc
    800043e0:	7ea080e7          	jalr	2026(ra) # 80000bc6 <uvmclear>
  stackbase = sp - PGSIZE;
    800043e4:	7c7d                	lui	s8,0xfffff
    800043e6:	9c5a                	add	s8,s8,s6
  for(argc = 0; argv[argc]; argc++) {
    800043e8:	e0043783          	ld	a5,-512(s0)
    800043ec:	6388                	ld	a0,0(a5)
    800043ee:	c535                	beqz	a0,8000445a <exec+0x216>
    800043f0:	e9040993          	addi	s3,s0,-368
    800043f4:	f9040c93          	addi	s9,s0,-112
  sp = sz;
    800043f8:	895a                	mv	s2,s6
    sp -= strlen(argv[argc]) + 1;
    800043fa:	ffffc097          	auipc	ra,0xffffc
    800043fe:	fe0080e7          	jalr	-32(ra) # 800003da <strlen>
    80004402:	2505                	addiw	a0,a0,1
    80004404:	40a90933          	sub	s2,s2,a0
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80004408:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    8000440c:	13896363          	bltu	s2,s8,80004532 <exec+0x2ee>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80004410:	e0043d83          	ld	s11,-512(s0)
    80004414:	000dba03          	ld	s4,0(s11)
    80004418:	8552                	mv	a0,s4
    8000441a:	ffffc097          	auipc	ra,0xffffc
    8000441e:	fc0080e7          	jalr	-64(ra) # 800003da <strlen>
    80004422:	0015069b          	addiw	a3,a0,1
    80004426:	8652                	mv	a2,s4
    80004428:	85ca                	mv	a1,s2
    8000442a:	855e                	mv	a0,s7
    8000442c:	ffffc097          	auipc	ra,0xffffc
    80004430:	7cc080e7          	jalr	1996(ra) # 80000bf8 <copyout>
    80004434:	10054363          	bltz	a0,8000453a <exec+0x2f6>
    ustack[argc] = sp;
    80004438:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    8000443c:	0485                	addi	s1,s1,1
    8000443e:	008d8793          	addi	a5,s11,8
    80004442:	e0f43023          	sd	a5,-512(s0)
    80004446:	008db503          	ld	a0,8(s11)
    8000444a:	c911                	beqz	a0,8000445e <exec+0x21a>
    if(argc >= MAXARG)
    8000444c:	09a1                	addi	s3,s3,8
    8000444e:	fb3c96e3          	bne	s9,s3,800043fa <exec+0x1b6>
  sz = sz1;
    80004452:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    80004456:	4481                	li	s1,0
    80004458:	a84d                	j	8000450a <exec+0x2c6>
  sp = sz;
    8000445a:	895a                	mv	s2,s6
  for(argc = 0; argv[argc]; argc++) {
    8000445c:	4481                	li	s1,0
  ustack[argc] = 0;
    8000445e:	00349793          	slli	a5,s1,0x3
    80004462:	f9040713          	addi	a4,s0,-112
    80004466:	97ba                	add	a5,a5,a4
    80004468:	f007b023          	sd	zero,-256(a5) # f00 <_entry-0x7ffff100>
  sp -= (argc+1) * sizeof(uint64);
    8000446c:	00148693          	addi	a3,s1,1
    80004470:	068e                	slli	a3,a3,0x3
    80004472:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80004476:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    8000447a:	01897663          	bgeu	s2,s8,80004486 <exec+0x242>
  sz = sz1;
    8000447e:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    80004482:	4481                	li	s1,0
    80004484:	a059                	j	8000450a <exec+0x2c6>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80004486:	e9040613          	addi	a2,s0,-368
    8000448a:	85ca                	mv	a1,s2
    8000448c:	855e                	mv	a0,s7
    8000448e:	ffffc097          	auipc	ra,0xffffc
    80004492:	76a080e7          	jalr	1898(ra) # 80000bf8 <copyout>
    80004496:	0a054663          	bltz	a0,80004542 <exec+0x2fe>
  p->trapframe->a1 = sp;
    8000449a:	060ab783          	ld	a5,96(s5)
    8000449e:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    800044a2:	df843783          	ld	a5,-520(s0)
    800044a6:	0007c703          	lbu	a4,0(a5)
    800044aa:	cf11                	beqz	a4,800044c6 <exec+0x282>
    800044ac:	0785                	addi	a5,a5,1
    if(*s == '/')
    800044ae:	02f00693          	li	a3,47
    800044b2:	a039                	j	800044c0 <exec+0x27c>
      last = s+1;
    800044b4:	def43c23          	sd	a5,-520(s0)
  for(last=s=path; *s; s++)
    800044b8:	0785                	addi	a5,a5,1
    800044ba:	fff7c703          	lbu	a4,-1(a5)
    800044be:	c701                	beqz	a4,800044c6 <exec+0x282>
    if(*s == '/')
    800044c0:	fed71ce3          	bne	a4,a3,800044b8 <exec+0x274>
    800044c4:	bfc5                	j	800044b4 <exec+0x270>
  safestrcpy(p->name, last, sizeof(p->name));
    800044c6:	4641                	li	a2,16
    800044c8:	df843583          	ld	a1,-520(s0)
    800044cc:	160a8513          	addi	a0,s5,352
    800044d0:	ffffc097          	auipc	ra,0xffffc
    800044d4:	ed8080e7          	jalr	-296(ra) # 800003a8 <safestrcpy>
  oldpagetable = p->pagetable;
    800044d8:	058ab503          	ld	a0,88(s5)
  p->pagetable = pagetable;
    800044dc:	057abc23          	sd	s7,88(s5)
  p->sz = sz;
    800044e0:	056ab823          	sd	s6,80(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    800044e4:	060ab783          	ld	a5,96(s5)
    800044e8:	e6843703          	ld	a4,-408(s0)
    800044ec:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    800044ee:	060ab783          	ld	a5,96(s5)
    800044f2:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    800044f6:	85ea                	mv	a1,s10
    800044f8:	ffffd097          	auipc	ra,0xffffd
    800044fc:	b9e080e7          	jalr	-1122(ra) # 80001096 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80004500:	0004851b          	sext.w	a0,s1
    80004504:	bbe1                	j	800042dc <exec+0x98>
    80004506:	e1243423          	sd	s2,-504(s0)
    proc_freepagetable(pagetable, sz);
    8000450a:	e0843583          	ld	a1,-504(s0)
    8000450e:	855e                	mv	a0,s7
    80004510:	ffffd097          	auipc	ra,0xffffd
    80004514:	b86080e7          	jalr	-1146(ra) # 80001096 <proc_freepagetable>
  if(ip){
    80004518:	da0498e3          	bnez	s1,800042c8 <exec+0x84>
  return -1;
    8000451c:	557d                	li	a0,-1
    8000451e:	bb7d                	j	800042dc <exec+0x98>
    80004520:	e1243423          	sd	s2,-504(s0)
    80004524:	b7dd                	j	8000450a <exec+0x2c6>
    80004526:	e1243423          	sd	s2,-504(s0)
    8000452a:	b7c5                	j	8000450a <exec+0x2c6>
    8000452c:	e1243423          	sd	s2,-504(s0)
    80004530:	bfe9                	j	8000450a <exec+0x2c6>
  sz = sz1;
    80004532:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    80004536:	4481                	li	s1,0
    80004538:	bfc9                	j	8000450a <exec+0x2c6>
  sz = sz1;
    8000453a:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    8000453e:	4481                	li	s1,0
    80004540:	b7e9                	j	8000450a <exec+0x2c6>
  sz = sz1;
    80004542:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    80004546:	4481                	li	s1,0
    80004548:	b7c9                	j	8000450a <exec+0x2c6>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    8000454a:	e0843903          	ld	s2,-504(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000454e:	2b05                	addiw	s6,s6,1
    80004550:	0389899b          	addiw	s3,s3,56
    80004554:	e8845783          	lhu	a5,-376(s0)
    80004558:	e2fb5be3          	bge	s6,a5,8000438e <exec+0x14a>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    8000455c:	2981                	sext.w	s3,s3
    8000455e:	03800713          	li	a4,56
    80004562:	86ce                	mv	a3,s3
    80004564:	e1840613          	addi	a2,s0,-488
    80004568:	4581                	li	a1,0
    8000456a:	8526                	mv	a0,s1
    8000456c:	fffff097          	auipc	ra,0xfffff
    80004570:	a84080e7          	jalr	-1404(ra) # 80002ff0 <readi>
    80004574:	03800793          	li	a5,56
    80004578:	f8f517e3          	bne	a0,a5,80004506 <exec+0x2c2>
    if(ph.type != ELF_PROG_LOAD)
    8000457c:	e1842783          	lw	a5,-488(s0)
    80004580:	4705                	li	a4,1
    80004582:	fce796e3          	bne	a5,a4,8000454e <exec+0x30a>
    if(ph.memsz < ph.filesz)
    80004586:	e4043603          	ld	a2,-448(s0)
    8000458a:	e3843783          	ld	a5,-456(s0)
    8000458e:	f8f669e3          	bltu	a2,a5,80004520 <exec+0x2dc>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80004592:	e2843783          	ld	a5,-472(s0)
    80004596:	963e                	add	a2,a2,a5
    80004598:	f8f667e3          	bltu	a2,a5,80004526 <exec+0x2e2>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    8000459c:	85ca                	mv	a1,s2
    8000459e:	855e                	mv	a0,s7
    800045a0:	ffffc097          	auipc	ra,0xffffc
    800045a4:	408080e7          	jalr	1032(ra) # 800009a8 <uvmalloc>
    800045a8:	e0a43423          	sd	a0,-504(s0)
    800045ac:	d141                	beqz	a0,8000452c <exec+0x2e8>
    if((ph.vaddr % PGSIZE) != 0)
    800045ae:	e2843d03          	ld	s10,-472(s0)
    800045b2:	df043783          	ld	a5,-528(s0)
    800045b6:	00fd77b3          	and	a5,s10,a5
    800045ba:	fba1                	bnez	a5,8000450a <exec+0x2c6>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    800045bc:	e2042d83          	lw	s11,-480(s0)
    800045c0:	e3842c03          	lw	s8,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    800045c4:	f80c03e3          	beqz	s8,8000454a <exec+0x306>
    800045c8:	8a62                	mv	s4,s8
    800045ca:	4901                	li	s2,0
    800045cc:	b345                	j	8000436c <exec+0x128>

00000000800045ce <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    800045ce:	7179                	addi	sp,sp,-48
    800045d0:	f406                	sd	ra,40(sp)
    800045d2:	f022                	sd	s0,32(sp)
    800045d4:	ec26                	sd	s1,24(sp)
    800045d6:	e84a                	sd	s2,16(sp)
    800045d8:	1800                	addi	s0,sp,48
    800045da:	892e                	mv	s2,a1
    800045dc:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    800045de:	fdc40593          	addi	a1,s0,-36
    800045e2:	ffffe097          	auipc	ra,0xffffe
    800045e6:	a00080e7          	jalr	-1536(ra) # 80001fe2 <argint>
    800045ea:	04054063          	bltz	a0,8000462a <argfd+0x5c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    800045ee:	fdc42703          	lw	a4,-36(s0)
    800045f2:	47bd                	li	a5,15
    800045f4:	02e7ed63          	bltu	a5,a4,8000462e <argfd+0x60>
    800045f8:	ffffd097          	auipc	ra,0xffffd
    800045fc:	93e080e7          	jalr	-1730(ra) # 80000f36 <myproc>
    80004600:	fdc42703          	lw	a4,-36(s0)
    80004604:	01a70793          	addi	a5,a4,26
    80004608:	078e                	slli	a5,a5,0x3
    8000460a:	953e                	add	a0,a0,a5
    8000460c:	651c                	ld	a5,8(a0)
    8000460e:	c395                	beqz	a5,80004632 <argfd+0x64>
    return -1;
  if(pfd)
    80004610:	00090463          	beqz	s2,80004618 <argfd+0x4a>
    *pfd = fd;
    80004614:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80004618:	4501                	li	a0,0
  if(pf)
    8000461a:	c091                	beqz	s1,8000461e <argfd+0x50>
    *pf = f;
    8000461c:	e09c                	sd	a5,0(s1)
}
    8000461e:	70a2                	ld	ra,40(sp)
    80004620:	7402                	ld	s0,32(sp)
    80004622:	64e2                	ld	s1,24(sp)
    80004624:	6942                	ld	s2,16(sp)
    80004626:	6145                	addi	sp,sp,48
    80004628:	8082                	ret
    return -1;
    8000462a:	557d                	li	a0,-1
    8000462c:	bfcd                	j	8000461e <argfd+0x50>
    return -1;
    8000462e:	557d                	li	a0,-1
    80004630:	b7fd                	j	8000461e <argfd+0x50>
    80004632:	557d                	li	a0,-1
    80004634:	b7ed                	j	8000461e <argfd+0x50>

0000000080004636 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80004636:	1101                	addi	sp,sp,-32
    80004638:	ec06                	sd	ra,24(sp)
    8000463a:	e822                	sd	s0,16(sp)
    8000463c:	e426                	sd	s1,8(sp)
    8000463e:	1000                	addi	s0,sp,32
    80004640:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80004642:	ffffd097          	auipc	ra,0xffffd
    80004646:	8f4080e7          	jalr	-1804(ra) # 80000f36 <myproc>
    8000464a:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    8000464c:	0d850793          	addi	a5,a0,216 # fffffffffffff0d8 <end+0xffffffff7ffd3e90>
    80004650:	4501                	li	a0,0
    80004652:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80004654:	6398                	ld	a4,0(a5)
    80004656:	cb19                	beqz	a4,8000466c <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    80004658:	2505                	addiw	a0,a0,1
    8000465a:	07a1                	addi	a5,a5,8
    8000465c:	fed51ce3          	bne	a0,a3,80004654 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80004660:	557d                	li	a0,-1
}
    80004662:	60e2                	ld	ra,24(sp)
    80004664:	6442                	ld	s0,16(sp)
    80004666:	64a2                	ld	s1,8(sp)
    80004668:	6105                	addi	sp,sp,32
    8000466a:	8082                	ret
      p->ofile[fd] = f;
    8000466c:	01a50793          	addi	a5,a0,26
    80004670:	078e                	slli	a5,a5,0x3
    80004672:	963e                	add	a2,a2,a5
    80004674:	e604                	sd	s1,8(a2)
      return fd;
    80004676:	b7f5                	j	80004662 <fdalloc+0x2c>

0000000080004678 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    80004678:	715d                	addi	sp,sp,-80
    8000467a:	e486                	sd	ra,72(sp)
    8000467c:	e0a2                	sd	s0,64(sp)
    8000467e:	fc26                	sd	s1,56(sp)
    80004680:	f84a                	sd	s2,48(sp)
    80004682:	f44e                	sd	s3,40(sp)
    80004684:	f052                	sd	s4,32(sp)
    80004686:	ec56                	sd	s5,24(sp)
    80004688:	0880                	addi	s0,sp,80
    8000468a:	89ae                	mv	s3,a1
    8000468c:	8ab2                	mv	s5,a2
    8000468e:	8a36                	mv	s4,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80004690:	fb040593          	addi	a1,s0,-80
    80004694:	fffff097          	auipc	ra,0xfffff
    80004698:	e7c080e7          	jalr	-388(ra) # 80003510 <nameiparent>
    8000469c:	892a                	mv	s2,a0
    8000469e:	12050f63          	beqz	a0,800047dc <create+0x164>
    return 0;

  ilock(dp);
    800046a2:	ffffe097          	auipc	ra,0xffffe
    800046a6:	69a080e7          	jalr	1690(ra) # 80002d3c <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    800046aa:	4601                	li	a2,0
    800046ac:	fb040593          	addi	a1,s0,-80
    800046b0:	854a                	mv	a0,s2
    800046b2:	fffff097          	auipc	ra,0xfffff
    800046b6:	b6e080e7          	jalr	-1170(ra) # 80003220 <dirlookup>
    800046ba:	84aa                	mv	s1,a0
    800046bc:	c921                	beqz	a0,8000470c <create+0x94>
    iunlockput(dp);
    800046be:	854a                	mv	a0,s2
    800046c0:	fffff097          	auipc	ra,0xfffff
    800046c4:	8de080e7          	jalr	-1826(ra) # 80002f9e <iunlockput>
    ilock(ip);
    800046c8:	8526                	mv	a0,s1
    800046ca:	ffffe097          	auipc	ra,0xffffe
    800046ce:	672080e7          	jalr	1650(ra) # 80002d3c <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    800046d2:	2981                	sext.w	s3,s3
    800046d4:	4789                	li	a5,2
    800046d6:	02f99463          	bne	s3,a5,800046fe <create+0x86>
    800046da:	04c4d783          	lhu	a5,76(s1)
    800046de:	37f9                	addiw	a5,a5,-2
    800046e0:	17c2                	slli	a5,a5,0x30
    800046e2:	93c1                	srli	a5,a5,0x30
    800046e4:	4705                	li	a4,1
    800046e6:	00f76c63          	bltu	a4,a5,800046fe <create+0x86>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
    800046ea:	8526                	mv	a0,s1
    800046ec:	60a6                	ld	ra,72(sp)
    800046ee:	6406                	ld	s0,64(sp)
    800046f0:	74e2                	ld	s1,56(sp)
    800046f2:	7942                	ld	s2,48(sp)
    800046f4:	79a2                	ld	s3,40(sp)
    800046f6:	7a02                	ld	s4,32(sp)
    800046f8:	6ae2                	ld	s5,24(sp)
    800046fa:	6161                	addi	sp,sp,80
    800046fc:	8082                	ret
    iunlockput(ip);
    800046fe:	8526                	mv	a0,s1
    80004700:	fffff097          	auipc	ra,0xfffff
    80004704:	89e080e7          	jalr	-1890(ra) # 80002f9e <iunlockput>
    return 0;
    80004708:	4481                	li	s1,0
    8000470a:	b7c5                	j	800046ea <create+0x72>
  if((ip = ialloc(dp->dev, type)) == 0)
    8000470c:	85ce                	mv	a1,s3
    8000470e:	00092503          	lw	a0,0(s2)
    80004712:	ffffe097          	auipc	ra,0xffffe
    80004716:	492080e7          	jalr	1170(ra) # 80002ba4 <ialloc>
    8000471a:	84aa                	mv	s1,a0
    8000471c:	c529                	beqz	a0,80004766 <create+0xee>
  ilock(ip);
    8000471e:	ffffe097          	auipc	ra,0xffffe
    80004722:	61e080e7          	jalr	1566(ra) # 80002d3c <ilock>
  ip->major = major;
    80004726:	05549723          	sh	s5,78(s1)
  ip->minor = minor;
    8000472a:	05449823          	sh	s4,80(s1)
  ip->nlink = 1;
    8000472e:	4785                	li	a5,1
    80004730:	04f49923          	sh	a5,82(s1)
  iupdate(ip);
    80004734:	8526                	mv	a0,s1
    80004736:	ffffe097          	auipc	ra,0xffffe
    8000473a:	53c080e7          	jalr	1340(ra) # 80002c72 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    8000473e:	2981                	sext.w	s3,s3
    80004740:	4785                	li	a5,1
    80004742:	02f98a63          	beq	s3,a5,80004776 <create+0xfe>
  if(dirlink(dp, name, ip->inum) < 0)
    80004746:	40d0                	lw	a2,4(s1)
    80004748:	fb040593          	addi	a1,s0,-80
    8000474c:	854a                	mv	a0,s2
    8000474e:	fffff097          	auipc	ra,0xfffff
    80004752:	ce2080e7          	jalr	-798(ra) # 80003430 <dirlink>
    80004756:	06054b63          	bltz	a0,800047cc <create+0x154>
  iunlockput(dp);
    8000475a:	854a                	mv	a0,s2
    8000475c:	fffff097          	auipc	ra,0xfffff
    80004760:	842080e7          	jalr	-1982(ra) # 80002f9e <iunlockput>
  return ip;
    80004764:	b759                	j	800046ea <create+0x72>
    panic("create: ialloc");
    80004766:	00004517          	auipc	a0,0x4
    8000476a:	f0250513          	addi	a0,a0,-254 # 80008668 <syscalls+0x2a0>
    8000476e:	00002097          	auipc	ra,0x2
    80004772:	9be080e7          	jalr	-1602(ra) # 8000612c <panic>
    dp->nlink++;  // for ".."
    80004776:	05295783          	lhu	a5,82(s2)
    8000477a:	2785                	addiw	a5,a5,1
    8000477c:	04f91923          	sh	a5,82(s2)
    iupdate(dp);
    80004780:	854a                	mv	a0,s2
    80004782:	ffffe097          	auipc	ra,0xffffe
    80004786:	4f0080e7          	jalr	1264(ra) # 80002c72 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    8000478a:	40d0                	lw	a2,4(s1)
    8000478c:	00004597          	auipc	a1,0x4
    80004790:	eec58593          	addi	a1,a1,-276 # 80008678 <syscalls+0x2b0>
    80004794:	8526                	mv	a0,s1
    80004796:	fffff097          	auipc	ra,0xfffff
    8000479a:	c9a080e7          	jalr	-870(ra) # 80003430 <dirlink>
    8000479e:	00054f63          	bltz	a0,800047bc <create+0x144>
    800047a2:	00492603          	lw	a2,4(s2)
    800047a6:	00004597          	auipc	a1,0x4
    800047aa:	eda58593          	addi	a1,a1,-294 # 80008680 <syscalls+0x2b8>
    800047ae:	8526                	mv	a0,s1
    800047b0:	fffff097          	auipc	ra,0xfffff
    800047b4:	c80080e7          	jalr	-896(ra) # 80003430 <dirlink>
    800047b8:	f80557e3          	bgez	a0,80004746 <create+0xce>
      panic("create dots");
    800047bc:	00004517          	auipc	a0,0x4
    800047c0:	ecc50513          	addi	a0,a0,-308 # 80008688 <syscalls+0x2c0>
    800047c4:	00002097          	auipc	ra,0x2
    800047c8:	968080e7          	jalr	-1688(ra) # 8000612c <panic>
    panic("create: dirlink");
    800047cc:	00004517          	auipc	a0,0x4
    800047d0:	ecc50513          	addi	a0,a0,-308 # 80008698 <syscalls+0x2d0>
    800047d4:	00002097          	auipc	ra,0x2
    800047d8:	958080e7          	jalr	-1704(ra) # 8000612c <panic>
    return 0;
    800047dc:	84aa                	mv	s1,a0
    800047de:	b731                	j	800046ea <create+0x72>

00000000800047e0 <sys_dup>:
{
    800047e0:	7179                	addi	sp,sp,-48
    800047e2:	f406                	sd	ra,40(sp)
    800047e4:	f022                	sd	s0,32(sp)
    800047e6:	ec26                	sd	s1,24(sp)
    800047e8:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    800047ea:	fd840613          	addi	a2,s0,-40
    800047ee:	4581                	li	a1,0
    800047f0:	4501                	li	a0,0
    800047f2:	00000097          	auipc	ra,0x0
    800047f6:	ddc080e7          	jalr	-548(ra) # 800045ce <argfd>
    return -1;
    800047fa:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    800047fc:	02054363          	bltz	a0,80004822 <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    80004800:	fd843503          	ld	a0,-40(s0)
    80004804:	00000097          	auipc	ra,0x0
    80004808:	e32080e7          	jalr	-462(ra) # 80004636 <fdalloc>
    8000480c:	84aa                	mv	s1,a0
    return -1;
    8000480e:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80004810:	00054963          	bltz	a0,80004822 <sys_dup+0x42>
  filedup(f);
    80004814:	fd843503          	ld	a0,-40(s0)
    80004818:	fffff097          	auipc	ra,0xfffff
    8000481c:	370080e7          	jalr	880(ra) # 80003b88 <filedup>
  return fd;
    80004820:	87a6                	mv	a5,s1
}
    80004822:	853e                	mv	a0,a5
    80004824:	70a2                	ld	ra,40(sp)
    80004826:	7402                	ld	s0,32(sp)
    80004828:	64e2                	ld	s1,24(sp)
    8000482a:	6145                	addi	sp,sp,48
    8000482c:	8082                	ret

000000008000482e <sys_read>:
{
    8000482e:	7179                	addi	sp,sp,-48
    80004830:	f406                	sd	ra,40(sp)
    80004832:	f022                	sd	s0,32(sp)
    80004834:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004836:	fe840613          	addi	a2,s0,-24
    8000483a:	4581                	li	a1,0
    8000483c:	4501                	li	a0,0
    8000483e:	00000097          	auipc	ra,0x0
    80004842:	d90080e7          	jalr	-624(ra) # 800045ce <argfd>
    return -1;
    80004846:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004848:	04054163          	bltz	a0,8000488a <sys_read+0x5c>
    8000484c:	fe440593          	addi	a1,s0,-28
    80004850:	4509                	li	a0,2
    80004852:	ffffd097          	auipc	ra,0xffffd
    80004856:	790080e7          	jalr	1936(ra) # 80001fe2 <argint>
    return -1;
    8000485a:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000485c:	02054763          	bltz	a0,8000488a <sys_read+0x5c>
    80004860:	fd840593          	addi	a1,s0,-40
    80004864:	4505                	li	a0,1
    80004866:	ffffd097          	auipc	ra,0xffffd
    8000486a:	79e080e7          	jalr	1950(ra) # 80002004 <argaddr>
    return -1;
    8000486e:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004870:	00054d63          	bltz	a0,8000488a <sys_read+0x5c>
  return fileread(f, p, n);
    80004874:	fe442603          	lw	a2,-28(s0)
    80004878:	fd843583          	ld	a1,-40(s0)
    8000487c:	fe843503          	ld	a0,-24(s0)
    80004880:	fffff097          	auipc	ra,0xfffff
    80004884:	494080e7          	jalr	1172(ra) # 80003d14 <fileread>
    80004888:	87aa                	mv	a5,a0
}
    8000488a:	853e                	mv	a0,a5
    8000488c:	70a2                	ld	ra,40(sp)
    8000488e:	7402                	ld	s0,32(sp)
    80004890:	6145                	addi	sp,sp,48
    80004892:	8082                	ret

0000000080004894 <sys_write>:
{
    80004894:	7179                	addi	sp,sp,-48
    80004896:	f406                	sd	ra,40(sp)
    80004898:	f022                	sd	s0,32(sp)
    8000489a:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000489c:	fe840613          	addi	a2,s0,-24
    800048a0:	4581                	li	a1,0
    800048a2:	4501                	li	a0,0
    800048a4:	00000097          	auipc	ra,0x0
    800048a8:	d2a080e7          	jalr	-726(ra) # 800045ce <argfd>
    return -1;
    800048ac:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800048ae:	04054163          	bltz	a0,800048f0 <sys_write+0x5c>
    800048b2:	fe440593          	addi	a1,s0,-28
    800048b6:	4509                	li	a0,2
    800048b8:	ffffd097          	auipc	ra,0xffffd
    800048bc:	72a080e7          	jalr	1834(ra) # 80001fe2 <argint>
    return -1;
    800048c0:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800048c2:	02054763          	bltz	a0,800048f0 <sys_write+0x5c>
    800048c6:	fd840593          	addi	a1,s0,-40
    800048ca:	4505                	li	a0,1
    800048cc:	ffffd097          	auipc	ra,0xffffd
    800048d0:	738080e7          	jalr	1848(ra) # 80002004 <argaddr>
    return -1;
    800048d4:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800048d6:	00054d63          	bltz	a0,800048f0 <sys_write+0x5c>
  return filewrite(f, p, n);
    800048da:	fe442603          	lw	a2,-28(s0)
    800048de:	fd843583          	ld	a1,-40(s0)
    800048e2:	fe843503          	ld	a0,-24(s0)
    800048e6:	fffff097          	auipc	ra,0xfffff
    800048ea:	4f0080e7          	jalr	1264(ra) # 80003dd6 <filewrite>
    800048ee:	87aa                	mv	a5,a0
}
    800048f0:	853e                	mv	a0,a5
    800048f2:	70a2                	ld	ra,40(sp)
    800048f4:	7402                	ld	s0,32(sp)
    800048f6:	6145                	addi	sp,sp,48
    800048f8:	8082                	ret

00000000800048fa <sys_close>:
{
    800048fa:	1101                	addi	sp,sp,-32
    800048fc:	ec06                	sd	ra,24(sp)
    800048fe:	e822                	sd	s0,16(sp)
    80004900:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80004902:	fe040613          	addi	a2,s0,-32
    80004906:	fec40593          	addi	a1,s0,-20
    8000490a:	4501                	li	a0,0
    8000490c:	00000097          	auipc	ra,0x0
    80004910:	cc2080e7          	jalr	-830(ra) # 800045ce <argfd>
    return -1;
    80004914:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80004916:	02054463          	bltz	a0,8000493e <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    8000491a:	ffffc097          	auipc	ra,0xffffc
    8000491e:	61c080e7          	jalr	1564(ra) # 80000f36 <myproc>
    80004922:	fec42783          	lw	a5,-20(s0)
    80004926:	07e9                	addi	a5,a5,26
    80004928:	078e                	slli	a5,a5,0x3
    8000492a:	97aa                	add	a5,a5,a0
    8000492c:	0007b423          	sd	zero,8(a5)
  fileclose(f);
    80004930:	fe043503          	ld	a0,-32(s0)
    80004934:	fffff097          	auipc	ra,0xfffff
    80004938:	2a6080e7          	jalr	678(ra) # 80003bda <fileclose>
  return 0;
    8000493c:	4781                	li	a5,0
}
    8000493e:	853e                	mv	a0,a5
    80004940:	60e2                	ld	ra,24(sp)
    80004942:	6442                	ld	s0,16(sp)
    80004944:	6105                	addi	sp,sp,32
    80004946:	8082                	ret

0000000080004948 <sys_fstat>:
{
    80004948:	1101                	addi	sp,sp,-32
    8000494a:	ec06                	sd	ra,24(sp)
    8000494c:	e822                	sd	s0,16(sp)
    8000494e:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004950:	fe840613          	addi	a2,s0,-24
    80004954:	4581                	li	a1,0
    80004956:	4501                	li	a0,0
    80004958:	00000097          	auipc	ra,0x0
    8000495c:	c76080e7          	jalr	-906(ra) # 800045ce <argfd>
    return -1;
    80004960:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004962:	02054563          	bltz	a0,8000498c <sys_fstat+0x44>
    80004966:	fe040593          	addi	a1,s0,-32
    8000496a:	4505                	li	a0,1
    8000496c:	ffffd097          	auipc	ra,0xffffd
    80004970:	698080e7          	jalr	1688(ra) # 80002004 <argaddr>
    return -1;
    80004974:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004976:	00054b63          	bltz	a0,8000498c <sys_fstat+0x44>
  return filestat(f, st);
    8000497a:	fe043583          	ld	a1,-32(s0)
    8000497e:	fe843503          	ld	a0,-24(s0)
    80004982:	fffff097          	auipc	ra,0xfffff
    80004986:	320080e7          	jalr	800(ra) # 80003ca2 <filestat>
    8000498a:	87aa                	mv	a5,a0
}
    8000498c:	853e                	mv	a0,a5
    8000498e:	60e2                	ld	ra,24(sp)
    80004990:	6442                	ld	s0,16(sp)
    80004992:	6105                	addi	sp,sp,32
    80004994:	8082                	ret

0000000080004996 <sys_link>:
{
    80004996:	7169                	addi	sp,sp,-304
    80004998:	f606                	sd	ra,296(sp)
    8000499a:	f222                	sd	s0,288(sp)
    8000499c:	ee26                	sd	s1,280(sp)
    8000499e:	ea4a                	sd	s2,272(sp)
    800049a0:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800049a2:	08000613          	li	a2,128
    800049a6:	ed040593          	addi	a1,s0,-304
    800049aa:	4501                	li	a0,0
    800049ac:	ffffd097          	auipc	ra,0xffffd
    800049b0:	67a080e7          	jalr	1658(ra) # 80002026 <argstr>
    return -1;
    800049b4:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800049b6:	10054e63          	bltz	a0,80004ad2 <sys_link+0x13c>
    800049ba:	08000613          	li	a2,128
    800049be:	f5040593          	addi	a1,s0,-176
    800049c2:	4505                	li	a0,1
    800049c4:	ffffd097          	auipc	ra,0xffffd
    800049c8:	662080e7          	jalr	1634(ra) # 80002026 <argstr>
    return -1;
    800049cc:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800049ce:	10054263          	bltz	a0,80004ad2 <sys_link+0x13c>
  begin_op();
    800049d2:	fffff097          	auipc	ra,0xfffff
    800049d6:	d3c080e7          	jalr	-708(ra) # 8000370e <begin_op>
  if((ip = namei(old)) == 0){
    800049da:	ed040513          	addi	a0,s0,-304
    800049de:	fffff097          	auipc	ra,0xfffff
    800049e2:	b14080e7          	jalr	-1260(ra) # 800034f2 <namei>
    800049e6:	84aa                	mv	s1,a0
    800049e8:	c551                	beqz	a0,80004a74 <sys_link+0xde>
  ilock(ip);
    800049ea:	ffffe097          	auipc	ra,0xffffe
    800049ee:	352080e7          	jalr	850(ra) # 80002d3c <ilock>
  if(ip->type == T_DIR){
    800049f2:	04c49703          	lh	a4,76(s1)
    800049f6:	4785                	li	a5,1
    800049f8:	08f70463          	beq	a4,a5,80004a80 <sys_link+0xea>
  ip->nlink++;
    800049fc:	0524d783          	lhu	a5,82(s1)
    80004a00:	2785                	addiw	a5,a5,1
    80004a02:	04f49923          	sh	a5,82(s1)
  iupdate(ip);
    80004a06:	8526                	mv	a0,s1
    80004a08:	ffffe097          	auipc	ra,0xffffe
    80004a0c:	26a080e7          	jalr	618(ra) # 80002c72 <iupdate>
  iunlock(ip);
    80004a10:	8526                	mv	a0,s1
    80004a12:	ffffe097          	auipc	ra,0xffffe
    80004a16:	3ec080e7          	jalr	1004(ra) # 80002dfe <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004a1a:	fd040593          	addi	a1,s0,-48
    80004a1e:	f5040513          	addi	a0,s0,-176
    80004a22:	fffff097          	auipc	ra,0xfffff
    80004a26:	aee080e7          	jalr	-1298(ra) # 80003510 <nameiparent>
    80004a2a:	892a                	mv	s2,a0
    80004a2c:	c935                	beqz	a0,80004aa0 <sys_link+0x10a>
  ilock(dp);
    80004a2e:	ffffe097          	auipc	ra,0xffffe
    80004a32:	30e080e7          	jalr	782(ra) # 80002d3c <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80004a36:	00092703          	lw	a4,0(s2)
    80004a3a:	409c                	lw	a5,0(s1)
    80004a3c:	04f71d63          	bne	a4,a5,80004a96 <sys_link+0x100>
    80004a40:	40d0                	lw	a2,4(s1)
    80004a42:	fd040593          	addi	a1,s0,-48
    80004a46:	854a                	mv	a0,s2
    80004a48:	fffff097          	auipc	ra,0xfffff
    80004a4c:	9e8080e7          	jalr	-1560(ra) # 80003430 <dirlink>
    80004a50:	04054363          	bltz	a0,80004a96 <sys_link+0x100>
  iunlockput(dp);
    80004a54:	854a                	mv	a0,s2
    80004a56:	ffffe097          	auipc	ra,0xffffe
    80004a5a:	548080e7          	jalr	1352(ra) # 80002f9e <iunlockput>
  iput(ip);
    80004a5e:	8526                	mv	a0,s1
    80004a60:	ffffe097          	auipc	ra,0xffffe
    80004a64:	496080e7          	jalr	1174(ra) # 80002ef6 <iput>
  end_op();
    80004a68:	fffff097          	auipc	ra,0xfffff
    80004a6c:	d26080e7          	jalr	-730(ra) # 8000378e <end_op>
  return 0;
    80004a70:	4781                	li	a5,0
    80004a72:	a085                	j	80004ad2 <sys_link+0x13c>
    end_op();
    80004a74:	fffff097          	auipc	ra,0xfffff
    80004a78:	d1a080e7          	jalr	-742(ra) # 8000378e <end_op>
    return -1;
    80004a7c:	57fd                	li	a5,-1
    80004a7e:	a891                	j	80004ad2 <sys_link+0x13c>
    iunlockput(ip);
    80004a80:	8526                	mv	a0,s1
    80004a82:	ffffe097          	auipc	ra,0xffffe
    80004a86:	51c080e7          	jalr	1308(ra) # 80002f9e <iunlockput>
    end_op();
    80004a8a:	fffff097          	auipc	ra,0xfffff
    80004a8e:	d04080e7          	jalr	-764(ra) # 8000378e <end_op>
    return -1;
    80004a92:	57fd                	li	a5,-1
    80004a94:	a83d                	j	80004ad2 <sys_link+0x13c>
    iunlockput(dp);
    80004a96:	854a                	mv	a0,s2
    80004a98:	ffffe097          	auipc	ra,0xffffe
    80004a9c:	506080e7          	jalr	1286(ra) # 80002f9e <iunlockput>
  ilock(ip);
    80004aa0:	8526                	mv	a0,s1
    80004aa2:	ffffe097          	auipc	ra,0xffffe
    80004aa6:	29a080e7          	jalr	666(ra) # 80002d3c <ilock>
  ip->nlink--;
    80004aaa:	0524d783          	lhu	a5,82(s1)
    80004aae:	37fd                	addiw	a5,a5,-1
    80004ab0:	04f49923          	sh	a5,82(s1)
  iupdate(ip);
    80004ab4:	8526                	mv	a0,s1
    80004ab6:	ffffe097          	auipc	ra,0xffffe
    80004aba:	1bc080e7          	jalr	444(ra) # 80002c72 <iupdate>
  iunlockput(ip);
    80004abe:	8526                	mv	a0,s1
    80004ac0:	ffffe097          	auipc	ra,0xffffe
    80004ac4:	4de080e7          	jalr	1246(ra) # 80002f9e <iunlockput>
  end_op();
    80004ac8:	fffff097          	auipc	ra,0xfffff
    80004acc:	cc6080e7          	jalr	-826(ra) # 8000378e <end_op>
  return -1;
    80004ad0:	57fd                	li	a5,-1
}
    80004ad2:	853e                	mv	a0,a5
    80004ad4:	70b2                	ld	ra,296(sp)
    80004ad6:	7412                	ld	s0,288(sp)
    80004ad8:	64f2                	ld	s1,280(sp)
    80004ada:	6952                	ld	s2,272(sp)
    80004adc:	6155                	addi	sp,sp,304
    80004ade:	8082                	ret

0000000080004ae0 <sys_unlink>:
{
    80004ae0:	7151                	addi	sp,sp,-240
    80004ae2:	f586                	sd	ra,232(sp)
    80004ae4:	f1a2                	sd	s0,224(sp)
    80004ae6:	eda6                	sd	s1,216(sp)
    80004ae8:	e9ca                	sd	s2,208(sp)
    80004aea:	e5ce                	sd	s3,200(sp)
    80004aec:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80004aee:	08000613          	li	a2,128
    80004af2:	f3040593          	addi	a1,s0,-208
    80004af6:	4501                	li	a0,0
    80004af8:	ffffd097          	auipc	ra,0xffffd
    80004afc:	52e080e7          	jalr	1326(ra) # 80002026 <argstr>
    80004b00:	18054163          	bltz	a0,80004c82 <sys_unlink+0x1a2>
  begin_op();
    80004b04:	fffff097          	auipc	ra,0xfffff
    80004b08:	c0a080e7          	jalr	-1014(ra) # 8000370e <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004b0c:	fb040593          	addi	a1,s0,-80
    80004b10:	f3040513          	addi	a0,s0,-208
    80004b14:	fffff097          	auipc	ra,0xfffff
    80004b18:	9fc080e7          	jalr	-1540(ra) # 80003510 <nameiparent>
    80004b1c:	84aa                	mv	s1,a0
    80004b1e:	c979                	beqz	a0,80004bf4 <sys_unlink+0x114>
  ilock(dp);
    80004b20:	ffffe097          	auipc	ra,0xffffe
    80004b24:	21c080e7          	jalr	540(ra) # 80002d3c <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80004b28:	00004597          	auipc	a1,0x4
    80004b2c:	b5058593          	addi	a1,a1,-1200 # 80008678 <syscalls+0x2b0>
    80004b30:	fb040513          	addi	a0,s0,-80
    80004b34:	ffffe097          	auipc	ra,0xffffe
    80004b38:	6d2080e7          	jalr	1746(ra) # 80003206 <namecmp>
    80004b3c:	14050a63          	beqz	a0,80004c90 <sys_unlink+0x1b0>
    80004b40:	00004597          	auipc	a1,0x4
    80004b44:	b4058593          	addi	a1,a1,-1216 # 80008680 <syscalls+0x2b8>
    80004b48:	fb040513          	addi	a0,s0,-80
    80004b4c:	ffffe097          	auipc	ra,0xffffe
    80004b50:	6ba080e7          	jalr	1722(ra) # 80003206 <namecmp>
    80004b54:	12050e63          	beqz	a0,80004c90 <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004b58:	f2c40613          	addi	a2,s0,-212
    80004b5c:	fb040593          	addi	a1,s0,-80
    80004b60:	8526                	mv	a0,s1
    80004b62:	ffffe097          	auipc	ra,0xffffe
    80004b66:	6be080e7          	jalr	1726(ra) # 80003220 <dirlookup>
    80004b6a:	892a                	mv	s2,a0
    80004b6c:	12050263          	beqz	a0,80004c90 <sys_unlink+0x1b0>
  ilock(ip);
    80004b70:	ffffe097          	auipc	ra,0xffffe
    80004b74:	1cc080e7          	jalr	460(ra) # 80002d3c <ilock>
  if(ip->nlink < 1)
    80004b78:	05291783          	lh	a5,82(s2)
    80004b7c:	08f05263          	blez	a5,80004c00 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004b80:	04c91703          	lh	a4,76(s2)
    80004b84:	4785                	li	a5,1
    80004b86:	08f70563          	beq	a4,a5,80004c10 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    80004b8a:	4641                	li	a2,16
    80004b8c:	4581                	li	a1,0
    80004b8e:	fc040513          	addi	a0,s0,-64
    80004b92:	ffffb097          	auipc	ra,0xffffb
    80004b96:	6c4080e7          	jalr	1732(ra) # 80000256 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004b9a:	4741                	li	a4,16
    80004b9c:	f2c42683          	lw	a3,-212(s0)
    80004ba0:	fc040613          	addi	a2,s0,-64
    80004ba4:	4581                	li	a1,0
    80004ba6:	8526                	mv	a0,s1
    80004ba8:	ffffe097          	auipc	ra,0xffffe
    80004bac:	540080e7          	jalr	1344(ra) # 800030e8 <writei>
    80004bb0:	47c1                	li	a5,16
    80004bb2:	0af51563          	bne	a0,a5,80004c5c <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    80004bb6:	04c91703          	lh	a4,76(s2)
    80004bba:	4785                	li	a5,1
    80004bbc:	0af70863          	beq	a4,a5,80004c6c <sys_unlink+0x18c>
  iunlockput(dp);
    80004bc0:	8526                	mv	a0,s1
    80004bc2:	ffffe097          	auipc	ra,0xffffe
    80004bc6:	3dc080e7          	jalr	988(ra) # 80002f9e <iunlockput>
  ip->nlink--;
    80004bca:	05295783          	lhu	a5,82(s2)
    80004bce:	37fd                	addiw	a5,a5,-1
    80004bd0:	04f91923          	sh	a5,82(s2)
  iupdate(ip);
    80004bd4:	854a                	mv	a0,s2
    80004bd6:	ffffe097          	auipc	ra,0xffffe
    80004bda:	09c080e7          	jalr	156(ra) # 80002c72 <iupdate>
  iunlockput(ip);
    80004bde:	854a                	mv	a0,s2
    80004be0:	ffffe097          	auipc	ra,0xffffe
    80004be4:	3be080e7          	jalr	958(ra) # 80002f9e <iunlockput>
  end_op();
    80004be8:	fffff097          	auipc	ra,0xfffff
    80004bec:	ba6080e7          	jalr	-1114(ra) # 8000378e <end_op>
  return 0;
    80004bf0:	4501                	li	a0,0
    80004bf2:	a84d                	j	80004ca4 <sys_unlink+0x1c4>
    end_op();
    80004bf4:	fffff097          	auipc	ra,0xfffff
    80004bf8:	b9a080e7          	jalr	-1126(ra) # 8000378e <end_op>
    return -1;
    80004bfc:	557d                	li	a0,-1
    80004bfe:	a05d                	j	80004ca4 <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    80004c00:	00004517          	auipc	a0,0x4
    80004c04:	aa850513          	addi	a0,a0,-1368 # 800086a8 <syscalls+0x2e0>
    80004c08:	00001097          	auipc	ra,0x1
    80004c0c:	524080e7          	jalr	1316(ra) # 8000612c <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004c10:	05492703          	lw	a4,84(s2)
    80004c14:	02000793          	li	a5,32
    80004c18:	f6e7f9e3          	bgeu	a5,a4,80004b8a <sys_unlink+0xaa>
    80004c1c:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004c20:	4741                	li	a4,16
    80004c22:	86ce                	mv	a3,s3
    80004c24:	f1840613          	addi	a2,s0,-232
    80004c28:	4581                	li	a1,0
    80004c2a:	854a                	mv	a0,s2
    80004c2c:	ffffe097          	auipc	ra,0xffffe
    80004c30:	3c4080e7          	jalr	964(ra) # 80002ff0 <readi>
    80004c34:	47c1                	li	a5,16
    80004c36:	00f51b63          	bne	a0,a5,80004c4c <sys_unlink+0x16c>
    if(de.inum != 0)
    80004c3a:	f1845783          	lhu	a5,-232(s0)
    80004c3e:	e7a1                	bnez	a5,80004c86 <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004c40:	29c1                	addiw	s3,s3,16
    80004c42:	05492783          	lw	a5,84(s2)
    80004c46:	fcf9ede3          	bltu	s3,a5,80004c20 <sys_unlink+0x140>
    80004c4a:	b781                	j	80004b8a <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80004c4c:	00004517          	auipc	a0,0x4
    80004c50:	a7450513          	addi	a0,a0,-1420 # 800086c0 <syscalls+0x2f8>
    80004c54:	00001097          	auipc	ra,0x1
    80004c58:	4d8080e7          	jalr	1240(ra) # 8000612c <panic>
    panic("unlink: writei");
    80004c5c:	00004517          	auipc	a0,0x4
    80004c60:	a7c50513          	addi	a0,a0,-1412 # 800086d8 <syscalls+0x310>
    80004c64:	00001097          	auipc	ra,0x1
    80004c68:	4c8080e7          	jalr	1224(ra) # 8000612c <panic>
    dp->nlink--;
    80004c6c:	0524d783          	lhu	a5,82(s1)
    80004c70:	37fd                	addiw	a5,a5,-1
    80004c72:	04f49923          	sh	a5,82(s1)
    iupdate(dp);
    80004c76:	8526                	mv	a0,s1
    80004c78:	ffffe097          	auipc	ra,0xffffe
    80004c7c:	ffa080e7          	jalr	-6(ra) # 80002c72 <iupdate>
    80004c80:	b781                	j	80004bc0 <sys_unlink+0xe0>
    return -1;
    80004c82:	557d                	li	a0,-1
    80004c84:	a005                	j	80004ca4 <sys_unlink+0x1c4>
    iunlockput(ip);
    80004c86:	854a                	mv	a0,s2
    80004c88:	ffffe097          	auipc	ra,0xffffe
    80004c8c:	316080e7          	jalr	790(ra) # 80002f9e <iunlockput>
  iunlockput(dp);
    80004c90:	8526                	mv	a0,s1
    80004c92:	ffffe097          	auipc	ra,0xffffe
    80004c96:	30c080e7          	jalr	780(ra) # 80002f9e <iunlockput>
  end_op();
    80004c9a:	fffff097          	auipc	ra,0xfffff
    80004c9e:	af4080e7          	jalr	-1292(ra) # 8000378e <end_op>
  return -1;
    80004ca2:	557d                	li	a0,-1
}
    80004ca4:	70ae                	ld	ra,232(sp)
    80004ca6:	740e                	ld	s0,224(sp)
    80004ca8:	64ee                	ld	s1,216(sp)
    80004caa:	694e                	ld	s2,208(sp)
    80004cac:	69ae                	ld	s3,200(sp)
    80004cae:	616d                	addi	sp,sp,240
    80004cb0:	8082                	ret

0000000080004cb2 <sys_open>:

uint64
sys_open(void)
{
    80004cb2:	7131                	addi	sp,sp,-192
    80004cb4:	fd06                	sd	ra,184(sp)
    80004cb6:	f922                	sd	s0,176(sp)
    80004cb8:	f526                	sd	s1,168(sp)
    80004cba:	f14a                	sd	s2,160(sp)
    80004cbc:	ed4e                	sd	s3,152(sp)
    80004cbe:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004cc0:	08000613          	li	a2,128
    80004cc4:	f5040593          	addi	a1,s0,-176
    80004cc8:	4501                	li	a0,0
    80004cca:	ffffd097          	auipc	ra,0xffffd
    80004cce:	35c080e7          	jalr	860(ra) # 80002026 <argstr>
    return -1;
    80004cd2:	54fd                	li	s1,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004cd4:	0c054163          	bltz	a0,80004d96 <sys_open+0xe4>
    80004cd8:	f4c40593          	addi	a1,s0,-180
    80004cdc:	4505                	li	a0,1
    80004cde:	ffffd097          	auipc	ra,0xffffd
    80004ce2:	304080e7          	jalr	772(ra) # 80001fe2 <argint>
    80004ce6:	0a054863          	bltz	a0,80004d96 <sys_open+0xe4>

  begin_op();
    80004cea:	fffff097          	auipc	ra,0xfffff
    80004cee:	a24080e7          	jalr	-1500(ra) # 8000370e <begin_op>

  if(omode & O_CREATE){
    80004cf2:	f4c42783          	lw	a5,-180(s0)
    80004cf6:	2007f793          	andi	a5,a5,512
    80004cfa:	cbdd                	beqz	a5,80004db0 <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    80004cfc:	4681                	li	a3,0
    80004cfe:	4601                	li	a2,0
    80004d00:	4589                	li	a1,2
    80004d02:	f5040513          	addi	a0,s0,-176
    80004d06:	00000097          	auipc	ra,0x0
    80004d0a:	972080e7          	jalr	-1678(ra) # 80004678 <create>
    80004d0e:	892a                	mv	s2,a0
    if(ip == 0){
    80004d10:	c959                	beqz	a0,80004da6 <sys_open+0xf4>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004d12:	04c91703          	lh	a4,76(s2)
    80004d16:	478d                	li	a5,3
    80004d18:	00f71763          	bne	a4,a5,80004d26 <sys_open+0x74>
    80004d1c:	04e95703          	lhu	a4,78(s2)
    80004d20:	47a5                	li	a5,9
    80004d22:	0ce7ec63          	bltu	a5,a4,80004dfa <sys_open+0x148>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004d26:	fffff097          	auipc	ra,0xfffff
    80004d2a:	df8080e7          	jalr	-520(ra) # 80003b1e <filealloc>
    80004d2e:	89aa                	mv	s3,a0
    80004d30:	10050263          	beqz	a0,80004e34 <sys_open+0x182>
    80004d34:	00000097          	auipc	ra,0x0
    80004d38:	902080e7          	jalr	-1790(ra) # 80004636 <fdalloc>
    80004d3c:	84aa                	mv	s1,a0
    80004d3e:	0e054663          	bltz	a0,80004e2a <sys_open+0x178>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004d42:	04c91703          	lh	a4,76(s2)
    80004d46:	478d                	li	a5,3
    80004d48:	0cf70463          	beq	a4,a5,80004e10 <sys_open+0x15e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004d4c:	4789                	li	a5,2
    80004d4e:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80004d52:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    80004d56:	0129bc23          	sd	s2,24(s3)
  f->readable = !(omode & O_WRONLY);
    80004d5a:	f4c42783          	lw	a5,-180(s0)
    80004d5e:	0017c713          	xori	a4,a5,1
    80004d62:	8b05                	andi	a4,a4,1
    80004d64:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004d68:	0037f713          	andi	a4,a5,3
    80004d6c:	00e03733          	snez	a4,a4
    80004d70:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004d74:	4007f793          	andi	a5,a5,1024
    80004d78:	c791                	beqz	a5,80004d84 <sys_open+0xd2>
    80004d7a:	04c91703          	lh	a4,76(s2)
    80004d7e:	4789                	li	a5,2
    80004d80:	08f70f63          	beq	a4,a5,80004e1e <sys_open+0x16c>
    itrunc(ip);
  }

  iunlock(ip);
    80004d84:	854a                	mv	a0,s2
    80004d86:	ffffe097          	auipc	ra,0xffffe
    80004d8a:	078080e7          	jalr	120(ra) # 80002dfe <iunlock>
  end_op();
    80004d8e:	fffff097          	auipc	ra,0xfffff
    80004d92:	a00080e7          	jalr	-1536(ra) # 8000378e <end_op>

  return fd;
}
    80004d96:	8526                	mv	a0,s1
    80004d98:	70ea                	ld	ra,184(sp)
    80004d9a:	744a                	ld	s0,176(sp)
    80004d9c:	74aa                	ld	s1,168(sp)
    80004d9e:	790a                	ld	s2,160(sp)
    80004da0:	69ea                	ld	s3,152(sp)
    80004da2:	6129                	addi	sp,sp,192
    80004da4:	8082                	ret
      end_op();
    80004da6:	fffff097          	auipc	ra,0xfffff
    80004daa:	9e8080e7          	jalr	-1560(ra) # 8000378e <end_op>
      return -1;
    80004dae:	b7e5                	j	80004d96 <sys_open+0xe4>
    if((ip = namei(path)) == 0){
    80004db0:	f5040513          	addi	a0,s0,-176
    80004db4:	ffffe097          	auipc	ra,0xffffe
    80004db8:	73e080e7          	jalr	1854(ra) # 800034f2 <namei>
    80004dbc:	892a                	mv	s2,a0
    80004dbe:	c905                	beqz	a0,80004dee <sys_open+0x13c>
    ilock(ip);
    80004dc0:	ffffe097          	auipc	ra,0xffffe
    80004dc4:	f7c080e7          	jalr	-132(ra) # 80002d3c <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80004dc8:	04c91703          	lh	a4,76(s2)
    80004dcc:	4785                	li	a5,1
    80004dce:	f4f712e3          	bne	a4,a5,80004d12 <sys_open+0x60>
    80004dd2:	f4c42783          	lw	a5,-180(s0)
    80004dd6:	dba1                	beqz	a5,80004d26 <sys_open+0x74>
      iunlockput(ip);
    80004dd8:	854a                	mv	a0,s2
    80004dda:	ffffe097          	auipc	ra,0xffffe
    80004dde:	1c4080e7          	jalr	452(ra) # 80002f9e <iunlockput>
      end_op();
    80004de2:	fffff097          	auipc	ra,0xfffff
    80004de6:	9ac080e7          	jalr	-1620(ra) # 8000378e <end_op>
      return -1;
    80004dea:	54fd                	li	s1,-1
    80004dec:	b76d                	j	80004d96 <sys_open+0xe4>
      end_op();
    80004dee:	fffff097          	auipc	ra,0xfffff
    80004df2:	9a0080e7          	jalr	-1632(ra) # 8000378e <end_op>
      return -1;
    80004df6:	54fd                	li	s1,-1
    80004df8:	bf79                	j	80004d96 <sys_open+0xe4>
    iunlockput(ip);
    80004dfa:	854a                	mv	a0,s2
    80004dfc:	ffffe097          	auipc	ra,0xffffe
    80004e00:	1a2080e7          	jalr	418(ra) # 80002f9e <iunlockput>
    end_op();
    80004e04:	fffff097          	auipc	ra,0xfffff
    80004e08:	98a080e7          	jalr	-1654(ra) # 8000378e <end_op>
    return -1;
    80004e0c:	54fd                	li	s1,-1
    80004e0e:	b761                	j	80004d96 <sys_open+0xe4>
    f->type = FD_DEVICE;
    80004e10:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80004e14:	04e91783          	lh	a5,78(s2)
    80004e18:	02f99223          	sh	a5,36(s3)
    80004e1c:	bf2d                	j	80004d56 <sys_open+0xa4>
    itrunc(ip);
    80004e1e:	854a                	mv	a0,s2
    80004e20:	ffffe097          	auipc	ra,0xffffe
    80004e24:	02a080e7          	jalr	42(ra) # 80002e4a <itrunc>
    80004e28:	bfb1                	j	80004d84 <sys_open+0xd2>
      fileclose(f);
    80004e2a:	854e                	mv	a0,s3
    80004e2c:	fffff097          	auipc	ra,0xfffff
    80004e30:	dae080e7          	jalr	-594(ra) # 80003bda <fileclose>
    iunlockput(ip);
    80004e34:	854a                	mv	a0,s2
    80004e36:	ffffe097          	auipc	ra,0xffffe
    80004e3a:	168080e7          	jalr	360(ra) # 80002f9e <iunlockput>
    end_op();
    80004e3e:	fffff097          	auipc	ra,0xfffff
    80004e42:	950080e7          	jalr	-1712(ra) # 8000378e <end_op>
    return -1;
    80004e46:	54fd                	li	s1,-1
    80004e48:	b7b9                	j	80004d96 <sys_open+0xe4>

0000000080004e4a <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80004e4a:	7175                	addi	sp,sp,-144
    80004e4c:	e506                	sd	ra,136(sp)
    80004e4e:	e122                	sd	s0,128(sp)
    80004e50:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004e52:	fffff097          	auipc	ra,0xfffff
    80004e56:	8bc080e7          	jalr	-1860(ra) # 8000370e <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004e5a:	08000613          	li	a2,128
    80004e5e:	f7040593          	addi	a1,s0,-144
    80004e62:	4501                	li	a0,0
    80004e64:	ffffd097          	auipc	ra,0xffffd
    80004e68:	1c2080e7          	jalr	450(ra) # 80002026 <argstr>
    80004e6c:	02054963          	bltz	a0,80004e9e <sys_mkdir+0x54>
    80004e70:	4681                	li	a3,0
    80004e72:	4601                	li	a2,0
    80004e74:	4585                	li	a1,1
    80004e76:	f7040513          	addi	a0,s0,-144
    80004e7a:	fffff097          	auipc	ra,0xfffff
    80004e7e:	7fe080e7          	jalr	2046(ra) # 80004678 <create>
    80004e82:	cd11                	beqz	a0,80004e9e <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004e84:	ffffe097          	auipc	ra,0xffffe
    80004e88:	11a080e7          	jalr	282(ra) # 80002f9e <iunlockput>
  end_op();
    80004e8c:	fffff097          	auipc	ra,0xfffff
    80004e90:	902080e7          	jalr	-1790(ra) # 8000378e <end_op>
  return 0;
    80004e94:	4501                	li	a0,0
}
    80004e96:	60aa                	ld	ra,136(sp)
    80004e98:	640a                	ld	s0,128(sp)
    80004e9a:	6149                	addi	sp,sp,144
    80004e9c:	8082                	ret
    end_op();
    80004e9e:	fffff097          	auipc	ra,0xfffff
    80004ea2:	8f0080e7          	jalr	-1808(ra) # 8000378e <end_op>
    return -1;
    80004ea6:	557d                	li	a0,-1
    80004ea8:	b7fd                	j	80004e96 <sys_mkdir+0x4c>

0000000080004eaa <sys_mknod>:

uint64
sys_mknod(void)
{
    80004eaa:	7135                	addi	sp,sp,-160
    80004eac:	ed06                	sd	ra,152(sp)
    80004eae:	e922                	sd	s0,144(sp)
    80004eb0:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004eb2:	fffff097          	auipc	ra,0xfffff
    80004eb6:	85c080e7          	jalr	-1956(ra) # 8000370e <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004eba:	08000613          	li	a2,128
    80004ebe:	f7040593          	addi	a1,s0,-144
    80004ec2:	4501                	li	a0,0
    80004ec4:	ffffd097          	auipc	ra,0xffffd
    80004ec8:	162080e7          	jalr	354(ra) # 80002026 <argstr>
    80004ecc:	04054a63          	bltz	a0,80004f20 <sys_mknod+0x76>
     argint(1, &major) < 0 ||
    80004ed0:	f6c40593          	addi	a1,s0,-148
    80004ed4:	4505                	li	a0,1
    80004ed6:	ffffd097          	auipc	ra,0xffffd
    80004eda:	10c080e7          	jalr	268(ra) # 80001fe2 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004ede:	04054163          	bltz	a0,80004f20 <sys_mknod+0x76>
     argint(2, &minor) < 0 ||
    80004ee2:	f6840593          	addi	a1,s0,-152
    80004ee6:	4509                	li	a0,2
    80004ee8:	ffffd097          	auipc	ra,0xffffd
    80004eec:	0fa080e7          	jalr	250(ra) # 80001fe2 <argint>
     argint(1, &major) < 0 ||
    80004ef0:	02054863          	bltz	a0,80004f20 <sys_mknod+0x76>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004ef4:	f6841683          	lh	a3,-152(s0)
    80004ef8:	f6c41603          	lh	a2,-148(s0)
    80004efc:	458d                	li	a1,3
    80004efe:	f7040513          	addi	a0,s0,-144
    80004f02:	fffff097          	auipc	ra,0xfffff
    80004f06:	776080e7          	jalr	1910(ra) # 80004678 <create>
     argint(2, &minor) < 0 ||
    80004f0a:	c919                	beqz	a0,80004f20 <sys_mknod+0x76>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004f0c:	ffffe097          	auipc	ra,0xffffe
    80004f10:	092080e7          	jalr	146(ra) # 80002f9e <iunlockput>
  end_op();
    80004f14:	fffff097          	auipc	ra,0xfffff
    80004f18:	87a080e7          	jalr	-1926(ra) # 8000378e <end_op>
  return 0;
    80004f1c:	4501                	li	a0,0
    80004f1e:	a031                	j	80004f2a <sys_mknod+0x80>
    end_op();
    80004f20:	fffff097          	auipc	ra,0xfffff
    80004f24:	86e080e7          	jalr	-1938(ra) # 8000378e <end_op>
    return -1;
    80004f28:	557d                	li	a0,-1
}
    80004f2a:	60ea                	ld	ra,152(sp)
    80004f2c:	644a                	ld	s0,144(sp)
    80004f2e:	610d                	addi	sp,sp,160
    80004f30:	8082                	ret

0000000080004f32 <sys_chdir>:

uint64
sys_chdir(void)
{
    80004f32:	7135                	addi	sp,sp,-160
    80004f34:	ed06                	sd	ra,152(sp)
    80004f36:	e922                	sd	s0,144(sp)
    80004f38:	e526                	sd	s1,136(sp)
    80004f3a:	e14a                	sd	s2,128(sp)
    80004f3c:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80004f3e:	ffffc097          	auipc	ra,0xffffc
    80004f42:	ff8080e7          	jalr	-8(ra) # 80000f36 <myproc>
    80004f46:	892a                	mv	s2,a0
  
  begin_op();
    80004f48:	ffffe097          	auipc	ra,0xffffe
    80004f4c:	7c6080e7          	jalr	1990(ra) # 8000370e <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80004f50:	08000613          	li	a2,128
    80004f54:	f6040593          	addi	a1,s0,-160
    80004f58:	4501                	li	a0,0
    80004f5a:	ffffd097          	auipc	ra,0xffffd
    80004f5e:	0cc080e7          	jalr	204(ra) # 80002026 <argstr>
    80004f62:	04054b63          	bltz	a0,80004fb8 <sys_chdir+0x86>
    80004f66:	f6040513          	addi	a0,s0,-160
    80004f6a:	ffffe097          	auipc	ra,0xffffe
    80004f6e:	588080e7          	jalr	1416(ra) # 800034f2 <namei>
    80004f72:	84aa                	mv	s1,a0
    80004f74:	c131                	beqz	a0,80004fb8 <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80004f76:	ffffe097          	auipc	ra,0xffffe
    80004f7a:	dc6080e7          	jalr	-570(ra) # 80002d3c <ilock>
  if(ip->type != T_DIR){
    80004f7e:	04c49703          	lh	a4,76(s1)
    80004f82:	4785                	li	a5,1
    80004f84:	04f71063          	bne	a4,a5,80004fc4 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80004f88:	8526                	mv	a0,s1
    80004f8a:	ffffe097          	auipc	ra,0xffffe
    80004f8e:	e74080e7          	jalr	-396(ra) # 80002dfe <iunlock>
  iput(p->cwd);
    80004f92:	15893503          	ld	a0,344(s2)
    80004f96:	ffffe097          	auipc	ra,0xffffe
    80004f9a:	f60080e7          	jalr	-160(ra) # 80002ef6 <iput>
  end_op();
    80004f9e:	ffffe097          	auipc	ra,0xffffe
    80004fa2:	7f0080e7          	jalr	2032(ra) # 8000378e <end_op>
  p->cwd = ip;
    80004fa6:	14993c23          	sd	s1,344(s2)
  return 0;
    80004faa:	4501                	li	a0,0
}
    80004fac:	60ea                	ld	ra,152(sp)
    80004fae:	644a                	ld	s0,144(sp)
    80004fb0:	64aa                	ld	s1,136(sp)
    80004fb2:	690a                	ld	s2,128(sp)
    80004fb4:	610d                	addi	sp,sp,160
    80004fb6:	8082                	ret
    end_op();
    80004fb8:	ffffe097          	auipc	ra,0xffffe
    80004fbc:	7d6080e7          	jalr	2006(ra) # 8000378e <end_op>
    return -1;
    80004fc0:	557d                	li	a0,-1
    80004fc2:	b7ed                	j	80004fac <sys_chdir+0x7a>
    iunlockput(ip);
    80004fc4:	8526                	mv	a0,s1
    80004fc6:	ffffe097          	auipc	ra,0xffffe
    80004fca:	fd8080e7          	jalr	-40(ra) # 80002f9e <iunlockput>
    end_op();
    80004fce:	ffffe097          	auipc	ra,0xffffe
    80004fd2:	7c0080e7          	jalr	1984(ra) # 8000378e <end_op>
    return -1;
    80004fd6:	557d                	li	a0,-1
    80004fd8:	bfd1                	j	80004fac <sys_chdir+0x7a>

0000000080004fda <sys_exec>:

uint64
sys_exec(void)
{
    80004fda:	7145                	addi	sp,sp,-464
    80004fdc:	e786                	sd	ra,456(sp)
    80004fde:	e3a2                	sd	s0,448(sp)
    80004fe0:	ff26                	sd	s1,440(sp)
    80004fe2:	fb4a                	sd	s2,432(sp)
    80004fe4:	f74e                	sd	s3,424(sp)
    80004fe6:	f352                	sd	s4,416(sp)
    80004fe8:	ef56                	sd	s5,408(sp)
    80004fea:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80004fec:	08000613          	li	a2,128
    80004ff0:	f4040593          	addi	a1,s0,-192
    80004ff4:	4501                	li	a0,0
    80004ff6:	ffffd097          	auipc	ra,0xffffd
    80004ffa:	030080e7          	jalr	48(ra) # 80002026 <argstr>
    return -1;
    80004ffe:	597d                	li	s2,-1
  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80005000:	0c054a63          	bltz	a0,800050d4 <sys_exec+0xfa>
    80005004:	e3840593          	addi	a1,s0,-456
    80005008:	4505                	li	a0,1
    8000500a:	ffffd097          	auipc	ra,0xffffd
    8000500e:	ffa080e7          	jalr	-6(ra) # 80002004 <argaddr>
    80005012:	0c054163          	bltz	a0,800050d4 <sys_exec+0xfa>
  }
  memset(argv, 0, sizeof(argv));
    80005016:	10000613          	li	a2,256
    8000501a:	4581                	li	a1,0
    8000501c:	e4040513          	addi	a0,s0,-448
    80005020:	ffffb097          	auipc	ra,0xffffb
    80005024:	236080e7          	jalr	566(ra) # 80000256 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80005028:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    8000502c:	89a6                	mv	s3,s1
    8000502e:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    80005030:	02000a13          	li	s4,32
    80005034:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80005038:	00391513          	slli	a0,s2,0x3
    8000503c:	e3040593          	addi	a1,s0,-464
    80005040:	e3843783          	ld	a5,-456(s0)
    80005044:	953e                	add	a0,a0,a5
    80005046:	ffffd097          	auipc	ra,0xffffd
    8000504a:	f02080e7          	jalr	-254(ra) # 80001f48 <fetchaddr>
    8000504e:	02054a63          	bltz	a0,80005082 <sys_exec+0xa8>
      goto bad;
    }
    if(uarg == 0){
    80005052:	e3043783          	ld	a5,-464(s0)
    80005056:	c3b9                	beqz	a5,8000509c <sys_exec+0xc2>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80005058:	ffffb097          	auipc	ra,0xffffb
    8000505c:	114080e7          	jalr	276(ra) # 8000016c <kalloc>
    80005060:	85aa                	mv	a1,a0
    80005062:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80005066:	cd11                	beqz	a0,80005082 <sys_exec+0xa8>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80005068:	6605                	lui	a2,0x1
    8000506a:	e3043503          	ld	a0,-464(s0)
    8000506e:	ffffd097          	auipc	ra,0xffffd
    80005072:	f2c080e7          	jalr	-212(ra) # 80001f9a <fetchstr>
    80005076:	00054663          	bltz	a0,80005082 <sys_exec+0xa8>
    if(i >= NELEM(argv)){
    8000507a:	0905                	addi	s2,s2,1
    8000507c:	09a1                	addi	s3,s3,8
    8000507e:	fb491be3          	bne	s2,s4,80005034 <sys_exec+0x5a>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005082:	10048913          	addi	s2,s1,256
    80005086:	6088                	ld	a0,0(s1)
    80005088:	c529                	beqz	a0,800050d2 <sys_exec+0xf8>
    kfree(argv[i]);
    8000508a:	ffffb097          	auipc	ra,0xffffb
    8000508e:	f92080e7          	jalr	-110(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005092:	04a1                	addi	s1,s1,8
    80005094:	ff2499e3          	bne	s1,s2,80005086 <sys_exec+0xac>
  return -1;
    80005098:	597d                	li	s2,-1
    8000509a:	a82d                	j	800050d4 <sys_exec+0xfa>
      argv[i] = 0;
    8000509c:	0a8e                	slli	s5,s5,0x3
    8000509e:	fc040793          	addi	a5,s0,-64
    800050a2:	9abe                	add	s5,s5,a5
    800050a4:	e80ab023          	sd	zero,-384(s5)
  int ret = exec(path, argv);
    800050a8:	e4040593          	addi	a1,s0,-448
    800050ac:	f4040513          	addi	a0,s0,-192
    800050b0:	fffff097          	auipc	ra,0xfffff
    800050b4:	194080e7          	jalr	404(ra) # 80004244 <exec>
    800050b8:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800050ba:	10048993          	addi	s3,s1,256
    800050be:	6088                	ld	a0,0(s1)
    800050c0:	c911                	beqz	a0,800050d4 <sys_exec+0xfa>
    kfree(argv[i]);
    800050c2:	ffffb097          	auipc	ra,0xffffb
    800050c6:	f5a080e7          	jalr	-166(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800050ca:	04a1                	addi	s1,s1,8
    800050cc:	ff3499e3          	bne	s1,s3,800050be <sys_exec+0xe4>
    800050d0:	a011                	j	800050d4 <sys_exec+0xfa>
  return -1;
    800050d2:	597d                	li	s2,-1
}
    800050d4:	854a                	mv	a0,s2
    800050d6:	60be                	ld	ra,456(sp)
    800050d8:	641e                	ld	s0,448(sp)
    800050da:	74fa                	ld	s1,440(sp)
    800050dc:	795a                	ld	s2,432(sp)
    800050de:	79ba                	ld	s3,424(sp)
    800050e0:	7a1a                	ld	s4,416(sp)
    800050e2:	6afa                	ld	s5,408(sp)
    800050e4:	6179                	addi	sp,sp,464
    800050e6:	8082                	ret

00000000800050e8 <sys_pipe>:

uint64
sys_pipe(void)
{
    800050e8:	7139                	addi	sp,sp,-64
    800050ea:	fc06                	sd	ra,56(sp)
    800050ec:	f822                	sd	s0,48(sp)
    800050ee:	f426                	sd	s1,40(sp)
    800050f0:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    800050f2:	ffffc097          	auipc	ra,0xffffc
    800050f6:	e44080e7          	jalr	-444(ra) # 80000f36 <myproc>
    800050fa:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    800050fc:	fd840593          	addi	a1,s0,-40
    80005100:	4501                	li	a0,0
    80005102:	ffffd097          	auipc	ra,0xffffd
    80005106:	f02080e7          	jalr	-254(ra) # 80002004 <argaddr>
    return -1;
    8000510a:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    8000510c:	0e054063          	bltz	a0,800051ec <sys_pipe+0x104>
  if(pipealloc(&rf, &wf) < 0)
    80005110:	fc840593          	addi	a1,s0,-56
    80005114:	fd040513          	addi	a0,s0,-48
    80005118:	fffff097          	auipc	ra,0xfffff
    8000511c:	df2080e7          	jalr	-526(ra) # 80003f0a <pipealloc>
    return -1;
    80005120:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80005122:	0c054563          	bltz	a0,800051ec <sys_pipe+0x104>
  fd0 = -1;
    80005126:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    8000512a:	fd043503          	ld	a0,-48(s0)
    8000512e:	fffff097          	auipc	ra,0xfffff
    80005132:	508080e7          	jalr	1288(ra) # 80004636 <fdalloc>
    80005136:	fca42223          	sw	a0,-60(s0)
    8000513a:	08054c63          	bltz	a0,800051d2 <sys_pipe+0xea>
    8000513e:	fc843503          	ld	a0,-56(s0)
    80005142:	fffff097          	auipc	ra,0xfffff
    80005146:	4f4080e7          	jalr	1268(ra) # 80004636 <fdalloc>
    8000514a:	fca42023          	sw	a0,-64(s0)
    8000514e:	06054863          	bltz	a0,800051be <sys_pipe+0xd6>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005152:	4691                	li	a3,4
    80005154:	fc440613          	addi	a2,s0,-60
    80005158:	fd843583          	ld	a1,-40(s0)
    8000515c:	6ca8                	ld	a0,88(s1)
    8000515e:	ffffc097          	auipc	ra,0xffffc
    80005162:	a9a080e7          	jalr	-1382(ra) # 80000bf8 <copyout>
    80005166:	02054063          	bltz	a0,80005186 <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    8000516a:	4691                	li	a3,4
    8000516c:	fc040613          	addi	a2,s0,-64
    80005170:	fd843583          	ld	a1,-40(s0)
    80005174:	0591                	addi	a1,a1,4
    80005176:	6ca8                	ld	a0,88(s1)
    80005178:	ffffc097          	auipc	ra,0xffffc
    8000517c:	a80080e7          	jalr	-1408(ra) # 80000bf8 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80005180:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005182:	06055563          	bgez	a0,800051ec <sys_pipe+0x104>
    p->ofile[fd0] = 0;
    80005186:	fc442783          	lw	a5,-60(s0)
    8000518a:	07e9                	addi	a5,a5,26
    8000518c:	078e                	slli	a5,a5,0x3
    8000518e:	97a6                	add	a5,a5,s1
    80005190:	0007b423          	sd	zero,8(a5)
    p->ofile[fd1] = 0;
    80005194:	fc042503          	lw	a0,-64(s0)
    80005198:	0569                	addi	a0,a0,26
    8000519a:	050e                	slli	a0,a0,0x3
    8000519c:	9526                	add	a0,a0,s1
    8000519e:	00053423          	sd	zero,8(a0)
    fileclose(rf);
    800051a2:	fd043503          	ld	a0,-48(s0)
    800051a6:	fffff097          	auipc	ra,0xfffff
    800051aa:	a34080e7          	jalr	-1484(ra) # 80003bda <fileclose>
    fileclose(wf);
    800051ae:	fc843503          	ld	a0,-56(s0)
    800051b2:	fffff097          	auipc	ra,0xfffff
    800051b6:	a28080e7          	jalr	-1496(ra) # 80003bda <fileclose>
    return -1;
    800051ba:	57fd                	li	a5,-1
    800051bc:	a805                	j	800051ec <sys_pipe+0x104>
    if(fd0 >= 0)
    800051be:	fc442783          	lw	a5,-60(s0)
    800051c2:	0007c863          	bltz	a5,800051d2 <sys_pipe+0xea>
      p->ofile[fd0] = 0;
    800051c6:	01a78513          	addi	a0,a5,26
    800051ca:	050e                	slli	a0,a0,0x3
    800051cc:	9526                	add	a0,a0,s1
    800051ce:	00053423          	sd	zero,8(a0)
    fileclose(rf);
    800051d2:	fd043503          	ld	a0,-48(s0)
    800051d6:	fffff097          	auipc	ra,0xfffff
    800051da:	a04080e7          	jalr	-1532(ra) # 80003bda <fileclose>
    fileclose(wf);
    800051de:	fc843503          	ld	a0,-56(s0)
    800051e2:	fffff097          	auipc	ra,0xfffff
    800051e6:	9f8080e7          	jalr	-1544(ra) # 80003bda <fileclose>
    return -1;
    800051ea:	57fd                	li	a5,-1
}
    800051ec:	853e                	mv	a0,a5
    800051ee:	70e2                	ld	ra,56(sp)
    800051f0:	7442                	ld	s0,48(sp)
    800051f2:	74a2                	ld	s1,40(sp)
    800051f4:	6121                	addi	sp,sp,64
    800051f6:	8082                	ret
	...

0000000080005200 <kernelvec>:
    80005200:	7111                	addi	sp,sp,-256
    80005202:	e006                	sd	ra,0(sp)
    80005204:	e40a                	sd	sp,8(sp)
    80005206:	e80e                	sd	gp,16(sp)
    80005208:	ec12                	sd	tp,24(sp)
    8000520a:	f016                	sd	t0,32(sp)
    8000520c:	f41a                	sd	t1,40(sp)
    8000520e:	f81e                	sd	t2,48(sp)
    80005210:	fc22                	sd	s0,56(sp)
    80005212:	e0a6                	sd	s1,64(sp)
    80005214:	e4aa                	sd	a0,72(sp)
    80005216:	e8ae                	sd	a1,80(sp)
    80005218:	ecb2                	sd	a2,88(sp)
    8000521a:	f0b6                	sd	a3,96(sp)
    8000521c:	f4ba                	sd	a4,104(sp)
    8000521e:	f8be                	sd	a5,112(sp)
    80005220:	fcc2                	sd	a6,120(sp)
    80005222:	e146                	sd	a7,128(sp)
    80005224:	e54a                	sd	s2,136(sp)
    80005226:	e94e                	sd	s3,144(sp)
    80005228:	ed52                	sd	s4,152(sp)
    8000522a:	f156                	sd	s5,160(sp)
    8000522c:	f55a                	sd	s6,168(sp)
    8000522e:	f95e                	sd	s7,176(sp)
    80005230:	fd62                	sd	s8,184(sp)
    80005232:	e1e6                	sd	s9,192(sp)
    80005234:	e5ea                	sd	s10,200(sp)
    80005236:	e9ee                	sd	s11,208(sp)
    80005238:	edf2                	sd	t3,216(sp)
    8000523a:	f1f6                	sd	t4,224(sp)
    8000523c:	f5fa                	sd	t5,232(sp)
    8000523e:	f9fe                	sd	t6,240(sp)
    80005240:	bd5fc0ef          	jal	ra,80001e14 <kerneltrap>
    80005244:	6082                	ld	ra,0(sp)
    80005246:	6122                	ld	sp,8(sp)
    80005248:	61c2                	ld	gp,16(sp)
    8000524a:	7282                	ld	t0,32(sp)
    8000524c:	7322                	ld	t1,40(sp)
    8000524e:	73c2                	ld	t2,48(sp)
    80005250:	7462                	ld	s0,56(sp)
    80005252:	6486                	ld	s1,64(sp)
    80005254:	6526                	ld	a0,72(sp)
    80005256:	65c6                	ld	a1,80(sp)
    80005258:	6666                	ld	a2,88(sp)
    8000525a:	7686                	ld	a3,96(sp)
    8000525c:	7726                	ld	a4,104(sp)
    8000525e:	77c6                	ld	a5,112(sp)
    80005260:	7866                	ld	a6,120(sp)
    80005262:	688a                	ld	a7,128(sp)
    80005264:	692a                	ld	s2,136(sp)
    80005266:	69ca                	ld	s3,144(sp)
    80005268:	6a6a                	ld	s4,152(sp)
    8000526a:	7a8a                	ld	s5,160(sp)
    8000526c:	7b2a                	ld	s6,168(sp)
    8000526e:	7bca                	ld	s7,176(sp)
    80005270:	7c6a                	ld	s8,184(sp)
    80005272:	6c8e                	ld	s9,192(sp)
    80005274:	6d2e                	ld	s10,200(sp)
    80005276:	6dce                	ld	s11,208(sp)
    80005278:	6e6e                	ld	t3,216(sp)
    8000527a:	7e8e                	ld	t4,224(sp)
    8000527c:	7f2e                	ld	t5,232(sp)
    8000527e:	7fce                	ld	t6,240(sp)
    80005280:	6111                	addi	sp,sp,256
    80005282:	10200073          	sret
    80005286:	00000013          	nop
    8000528a:	00000013          	nop
    8000528e:	0001                	nop

0000000080005290 <timervec>:
    80005290:	34051573          	csrrw	a0,mscratch,a0
    80005294:	e10c                	sd	a1,0(a0)
    80005296:	e510                	sd	a2,8(a0)
    80005298:	e914                	sd	a3,16(a0)
    8000529a:	6d0c                	ld	a1,24(a0)
    8000529c:	7110                	ld	a2,32(a0)
    8000529e:	6194                	ld	a3,0(a1)
    800052a0:	96b2                	add	a3,a3,a2
    800052a2:	e194                	sd	a3,0(a1)
    800052a4:	4589                	li	a1,2
    800052a6:	14459073          	csrw	sip,a1
    800052aa:	6914                	ld	a3,16(a0)
    800052ac:	6510                	ld	a2,8(a0)
    800052ae:	610c                	ld	a1,0(a0)
    800052b0:	34051573          	csrrw	a0,mscratch,a0
    800052b4:	30200073          	mret
	...

00000000800052ba <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    800052ba:	1141                	addi	sp,sp,-16
    800052bc:	e422                	sd	s0,8(sp)
    800052be:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    800052c0:	0c0007b7          	lui	a5,0xc000
    800052c4:	4705                	li	a4,1
    800052c6:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    800052c8:	c3d8                	sw	a4,4(a5)
}
    800052ca:	6422                	ld	s0,8(sp)
    800052cc:	0141                	addi	sp,sp,16
    800052ce:	8082                	ret

00000000800052d0 <plicinithart>:

void
plicinithart(void)
{
    800052d0:	1141                	addi	sp,sp,-16
    800052d2:	e406                	sd	ra,8(sp)
    800052d4:	e022                	sd	s0,0(sp)
    800052d6:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800052d8:	ffffc097          	auipc	ra,0xffffc
    800052dc:	c32080e7          	jalr	-974(ra) # 80000f0a <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    800052e0:	0085171b          	slliw	a4,a0,0x8
    800052e4:	0c0027b7          	lui	a5,0xc002
    800052e8:	97ba                	add	a5,a5,a4
    800052ea:	40200713          	li	a4,1026
    800052ee:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    800052f2:	00d5151b          	slliw	a0,a0,0xd
    800052f6:	0c2017b7          	lui	a5,0xc201
    800052fa:	953e                	add	a0,a0,a5
    800052fc:	00052023          	sw	zero,0(a0)
}
    80005300:	60a2                	ld	ra,8(sp)
    80005302:	6402                	ld	s0,0(sp)
    80005304:	0141                	addi	sp,sp,16
    80005306:	8082                	ret

0000000080005308 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80005308:	1141                	addi	sp,sp,-16
    8000530a:	e406                	sd	ra,8(sp)
    8000530c:	e022                	sd	s0,0(sp)
    8000530e:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005310:	ffffc097          	auipc	ra,0xffffc
    80005314:	bfa080e7          	jalr	-1030(ra) # 80000f0a <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80005318:	00d5179b          	slliw	a5,a0,0xd
    8000531c:	0c201537          	lui	a0,0xc201
    80005320:	953e                	add	a0,a0,a5
  return irq;
}
    80005322:	4148                	lw	a0,4(a0)
    80005324:	60a2                	ld	ra,8(sp)
    80005326:	6402                	ld	s0,0(sp)
    80005328:	0141                	addi	sp,sp,16
    8000532a:	8082                	ret

000000008000532c <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    8000532c:	1101                	addi	sp,sp,-32
    8000532e:	ec06                	sd	ra,24(sp)
    80005330:	e822                	sd	s0,16(sp)
    80005332:	e426                	sd	s1,8(sp)
    80005334:	1000                	addi	s0,sp,32
    80005336:	84aa                	mv	s1,a0
  int hart = cpuid();
    80005338:	ffffc097          	auipc	ra,0xffffc
    8000533c:	bd2080e7          	jalr	-1070(ra) # 80000f0a <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80005340:	00d5151b          	slliw	a0,a0,0xd
    80005344:	0c2017b7          	lui	a5,0xc201
    80005348:	97aa                	add	a5,a5,a0
    8000534a:	c3c4                	sw	s1,4(a5)
}
    8000534c:	60e2                	ld	ra,24(sp)
    8000534e:	6442                	ld	s0,16(sp)
    80005350:	64a2                	ld	s1,8(sp)
    80005352:	6105                	addi	sp,sp,32
    80005354:	8082                	ret

0000000080005356 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80005356:	1141                	addi	sp,sp,-16
    80005358:	e406                	sd	ra,8(sp)
    8000535a:	e022                	sd	s0,0(sp)
    8000535c:	0800                	addi	s0,sp,16
  if(i >= NUM)
    8000535e:	479d                	li	a5,7
    80005360:	06a7c963          	blt	a5,a0,800053d2 <free_desc+0x7c>
    panic("free_desc 1");
  if(disk.free[i])
    80005364:	00019797          	auipc	a5,0x19
    80005368:	c9c78793          	addi	a5,a5,-868 # 8001e000 <disk>
    8000536c:	00a78733          	add	a4,a5,a0
    80005370:	6789                	lui	a5,0x2
    80005372:	97ba                	add	a5,a5,a4
    80005374:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    80005378:	e7ad                	bnez	a5,800053e2 <free_desc+0x8c>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    8000537a:	00451793          	slli	a5,a0,0x4
    8000537e:	0001b717          	auipc	a4,0x1b
    80005382:	c8270713          	addi	a4,a4,-894 # 80020000 <disk+0x2000>
    80005386:	6314                	ld	a3,0(a4)
    80005388:	96be                	add	a3,a3,a5
    8000538a:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    8000538e:	6314                	ld	a3,0(a4)
    80005390:	96be                	add	a3,a3,a5
    80005392:	0006a423          	sw	zero,8(a3)
  disk.desc[i].flags = 0;
    80005396:	6314                	ld	a3,0(a4)
    80005398:	96be                	add	a3,a3,a5
    8000539a:	00069623          	sh	zero,12(a3)
  disk.desc[i].next = 0;
    8000539e:	6318                	ld	a4,0(a4)
    800053a0:	97ba                	add	a5,a5,a4
    800053a2:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    800053a6:	00019797          	auipc	a5,0x19
    800053aa:	c5a78793          	addi	a5,a5,-934 # 8001e000 <disk>
    800053ae:	97aa                	add	a5,a5,a0
    800053b0:	6509                	lui	a0,0x2
    800053b2:	953e                	add	a0,a0,a5
    800053b4:	4785                	li	a5,1
    800053b6:	00f50c23          	sb	a5,24(a0) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk.free[0]);
    800053ba:	0001b517          	auipc	a0,0x1b
    800053be:	c5e50513          	addi	a0,a0,-930 # 80020018 <disk+0x2018>
    800053c2:	ffffc097          	auipc	ra,0xffffc
    800053c6:	3bc080e7          	jalr	956(ra) # 8000177e <wakeup>
}
    800053ca:	60a2                	ld	ra,8(sp)
    800053cc:	6402                	ld	s0,0(sp)
    800053ce:	0141                	addi	sp,sp,16
    800053d0:	8082                	ret
    panic("free_desc 1");
    800053d2:	00003517          	auipc	a0,0x3
    800053d6:	31650513          	addi	a0,a0,790 # 800086e8 <syscalls+0x320>
    800053da:	00001097          	auipc	ra,0x1
    800053de:	d52080e7          	jalr	-686(ra) # 8000612c <panic>
    panic("free_desc 2");
    800053e2:	00003517          	auipc	a0,0x3
    800053e6:	31650513          	addi	a0,a0,790 # 800086f8 <syscalls+0x330>
    800053ea:	00001097          	auipc	ra,0x1
    800053ee:	d42080e7          	jalr	-702(ra) # 8000612c <panic>

00000000800053f2 <virtio_disk_init>:
{
    800053f2:	1101                	addi	sp,sp,-32
    800053f4:	ec06                	sd	ra,24(sp)
    800053f6:	e822                	sd	s0,16(sp)
    800053f8:	e426                	sd	s1,8(sp)
    800053fa:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    800053fc:	00003597          	auipc	a1,0x3
    80005400:	30c58593          	addi	a1,a1,780 # 80008708 <syscalls+0x340>
    80005404:	0001b517          	auipc	a0,0x1b
    80005408:	d2450513          	addi	a0,a0,-732 # 80020128 <disk+0x2128>
    8000540c:	00001097          	auipc	ra,0x1
    80005410:	3d0080e7          	jalr	976(ra) # 800067dc <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005414:	100017b7          	lui	a5,0x10001
    80005418:	4398                	lw	a4,0(a5)
    8000541a:	2701                	sext.w	a4,a4
    8000541c:	747277b7          	lui	a5,0x74727
    80005420:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80005424:	0ef71163          	bne	a4,a5,80005506 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80005428:	100017b7          	lui	a5,0x10001
    8000542c:	43dc                	lw	a5,4(a5)
    8000542e:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005430:	4705                	li	a4,1
    80005432:	0ce79a63          	bne	a5,a4,80005506 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005436:	100017b7          	lui	a5,0x10001
    8000543a:	479c                	lw	a5,8(a5)
    8000543c:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    8000543e:	4709                	li	a4,2
    80005440:	0ce79363          	bne	a5,a4,80005506 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80005444:	100017b7          	lui	a5,0x10001
    80005448:	47d8                	lw	a4,12(a5)
    8000544a:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000544c:	554d47b7          	lui	a5,0x554d4
    80005450:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80005454:	0af71963          	bne	a4,a5,80005506 <virtio_disk_init+0x114>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005458:	100017b7          	lui	a5,0x10001
    8000545c:	4705                	li	a4,1
    8000545e:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005460:	470d                	li	a4,3
    80005462:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80005464:	4b94                	lw	a3,16(a5)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80005466:	c7ffe737          	lui	a4,0xc7ffe
    8000546a:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fd3517>
    8000546e:	8f75                	and	a4,a4,a3
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80005470:	2701                	sext.w	a4,a4
    80005472:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005474:	472d                	li	a4,11
    80005476:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005478:	473d                	li	a4,15
    8000547a:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    8000547c:	6705                	lui	a4,0x1
    8000547e:	d798                	sw	a4,40(a5)
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80005480:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80005484:	5bdc                	lw	a5,52(a5)
    80005486:	2781                	sext.w	a5,a5
  if(max == 0)
    80005488:	c7d9                	beqz	a5,80005516 <virtio_disk_init+0x124>
  if(max < NUM)
    8000548a:	471d                	li	a4,7
    8000548c:	08f77d63          	bgeu	a4,a5,80005526 <virtio_disk_init+0x134>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80005490:	100014b7          	lui	s1,0x10001
    80005494:	47a1                	li	a5,8
    80005496:	dc9c                	sw	a5,56(s1)
  memset(disk.pages, 0, sizeof(disk.pages));
    80005498:	6609                	lui	a2,0x2
    8000549a:	4581                	li	a1,0
    8000549c:	00019517          	auipc	a0,0x19
    800054a0:	b6450513          	addi	a0,a0,-1180 # 8001e000 <disk>
    800054a4:	ffffb097          	auipc	ra,0xffffb
    800054a8:	db2080e7          	jalr	-590(ra) # 80000256 <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    800054ac:	00019717          	auipc	a4,0x19
    800054b0:	b5470713          	addi	a4,a4,-1196 # 8001e000 <disk>
    800054b4:	00c75793          	srli	a5,a4,0xc
    800054b8:	2781                	sext.w	a5,a5
    800054ba:	c0bc                	sw	a5,64(s1)
  disk.desc = (struct virtq_desc *) disk.pages;
    800054bc:	0001b797          	auipc	a5,0x1b
    800054c0:	b4478793          	addi	a5,a5,-1212 # 80020000 <disk+0x2000>
    800054c4:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    800054c6:	00019717          	auipc	a4,0x19
    800054ca:	bba70713          	addi	a4,a4,-1094 # 8001e080 <disk+0x80>
    800054ce:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    800054d0:	0001a717          	auipc	a4,0x1a
    800054d4:	b3070713          	addi	a4,a4,-1232 # 8001f000 <disk+0x1000>
    800054d8:	eb98                	sd	a4,16(a5)
    disk.free[i] = 1;
    800054da:	4705                	li	a4,1
    800054dc:	00e78c23          	sb	a4,24(a5)
    800054e0:	00e78ca3          	sb	a4,25(a5)
    800054e4:	00e78d23          	sb	a4,26(a5)
    800054e8:	00e78da3          	sb	a4,27(a5)
    800054ec:	00e78e23          	sb	a4,28(a5)
    800054f0:	00e78ea3          	sb	a4,29(a5)
    800054f4:	00e78f23          	sb	a4,30(a5)
    800054f8:	00e78fa3          	sb	a4,31(a5)
}
    800054fc:	60e2                	ld	ra,24(sp)
    800054fe:	6442                	ld	s0,16(sp)
    80005500:	64a2                	ld	s1,8(sp)
    80005502:	6105                	addi	sp,sp,32
    80005504:	8082                	ret
    panic("could not find virtio disk");
    80005506:	00003517          	auipc	a0,0x3
    8000550a:	21250513          	addi	a0,a0,530 # 80008718 <syscalls+0x350>
    8000550e:	00001097          	auipc	ra,0x1
    80005512:	c1e080e7          	jalr	-994(ra) # 8000612c <panic>
    panic("virtio disk has no queue 0");
    80005516:	00003517          	auipc	a0,0x3
    8000551a:	22250513          	addi	a0,a0,546 # 80008738 <syscalls+0x370>
    8000551e:	00001097          	auipc	ra,0x1
    80005522:	c0e080e7          	jalr	-1010(ra) # 8000612c <panic>
    panic("virtio disk max queue too short");
    80005526:	00003517          	auipc	a0,0x3
    8000552a:	23250513          	addi	a0,a0,562 # 80008758 <syscalls+0x390>
    8000552e:	00001097          	auipc	ra,0x1
    80005532:	bfe080e7          	jalr	-1026(ra) # 8000612c <panic>

0000000080005536 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80005536:	7159                	addi	sp,sp,-112
    80005538:	f486                	sd	ra,104(sp)
    8000553a:	f0a2                	sd	s0,96(sp)
    8000553c:	eca6                	sd	s1,88(sp)
    8000553e:	e8ca                	sd	s2,80(sp)
    80005540:	e4ce                	sd	s3,72(sp)
    80005542:	e0d2                	sd	s4,64(sp)
    80005544:	fc56                	sd	s5,56(sp)
    80005546:	f85a                	sd	s6,48(sp)
    80005548:	f45e                	sd	s7,40(sp)
    8000554a:	f062                	sd	s8,32(sp)
    8000554c:	ec66                	sd	s9,24(sp)
    8000554e:	e86a                	sd	s10,16(sp)
    80005550:	1880                	addi	s0,sp,112
    80005552:	892a                	mv	s2,a0
    80005554:	8d2e                	mv	s10,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80005556:	00c52c83          	lw	s9,12(a0)
    8000555a:	001c9c9b          	slliw	s9,s9,0x1
    8000555e:	1c82                	slli	s9,s9,0x20
    80005560:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    80005564:	0001b517          	auipc	a0,0x1b
    80005568:	bc450513          	addi	a0,a0,-1084 # 80020128 <disk+0x2128>
    8000556c:	00001097          	auipc	ra,0x1
    80005570:	0f4080e7          	jalr	244(ra) # 80006660 <acquire>
  for(int i = 0; i < 3; i++){
    80005574:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    80005576:	4c21                	li	s8,8
      disk.free[i] = 0;
    80005578:	00019b97          	auipc	s7,0x19
    8000557c:	a88b8b93          	addi	s7,s7,-1400 # 8001e000 <disk>
    80005580:	6b09                	lui	s6,0x2
  for(int i = 0; i < 3; i++){
    80005582:	4a8d                	li	s5,3
  for(int i = 0; i < NUM; i++){
    80005584:	8a4e                	mv	s4,s3
    80005586:	a051                	j	8000560a <virtio_disk_rw+0xd4>
      disk.free[i] = 0;
    80005588:	00fb86b3          	add	a3,s7,a5
    8000558c:	96da                	add	a3,a3,s6
    8000558e:	00068c23          	sb	zero,24(a3)
    idx[i] = alloc_desc();
    80005592:	c21c                	sw	a5,0(a2)
    if(idx[i] < 0){
    80005594:	0207c563          	bltz	a5,800055be <virtio_disk_rw+0x88>
  for(int i = 0; i < 3; i++){
    80005598:	2485                	addiw	s1,s1,1
    8000559a:	0711                	addi	a4,a4,4
    8000559c:	25548063          	beq	s1,s5,800057dc <virtio_disk_rw+0x2a6>
    idx[i] = alloc_desc();
    800055a0:	863a                	mv	a2,a4
  for(int i = 0; i < NUM; i++){
    800055a2:	0001b697          	auipc	a3,0x1b
    800055a6:	a7668693          	addi	a3,a3,-1418 # 80020018 <disk+0x2018>
    800055aa:	87d2                	mv	a5,s4
    if(disk.free[i]){
    800055ac:	0006c583          	lbu	a1,0(a3)
    800055b0:	fde1                	bnez	a1,80005588 <virtio_disk_rw+0x52>
  for(int i = 0; i < NUM; i++){
    800055b2:	2785                	addiw	a5,a5,1
    800055b4:	0685                	addi	a3,a3,1
    800055b6:	ff879be3          	bne	a5,s8,800055ac <virtio_disk_rw+0x76>
    idx[i] = alloc_desc();
    800055ba:	57fd                	li	a5,-1
    800055bc:	c21c                	sw	a5,0(a2)
      for(int j = 0; j < i; j++)
    800055be:	02905a63          	blez	s1,800055f2 <virtio_disk_rw+0xbc>
        free_desc(idx[j]);
    800055c2:	f9042503          	lw	a0,-112(s0)
    800055c6:	00000097          	auipc	ra,0x0
    800055ca:	d90080e7          	jalr	-624(ra) # 80005356 <free_desc>
      for(int j = 0; j < i; j++)
    800055ce:	4785                	li	a5,1
    800055d0:	0297d163          	bge	a5,s1,800055f2 <virtio_disk_rw+0xbc>
        free_desc(idx[j]);
    800055d4:	f9442503          	lw	a0,-108(s0)
    800055d8:	00000097          	auipc	ra,0x0
    800055dc:	d7e080e7          	jalr	-642(ra) # 80005356 <free_desc>
      for(int j = 0; j < i; j++)
    800055e0:	4789                	li	a5,2
    800055e2:	0097d863          	bge	a5,s1,800055f2 <virtio_disk_rw+0xbc>
        free_desc(idx[j]);
    800055e6:	f9842503          	lw	a0,-104(s0)
    800055ea:	00000097          	auipc	ra,0x0
    800055ee:	d6c080e7          	jalr	-660(ra) # 80005356 <free_desc>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    800055f2:	0001b597          	auipc	a1,0x1b
    800055f6:	b3658593          	addi	a1,a1,-1226 # 80020128 <disk+0x2128>
    800055fa:	0001b517          	auipc	a0,0x1b
    800055fe:	a1e50513          	addi	a0,a0,-1506 # 80020018 <disk+0x2018>
    80005602:	ffffc097          	auipc	ra,0xffffc
    80005606:	ff0080e7          	jalr	-16(ra) # 800015f2 <sleep>
  for(int i = 0; i < 3; i++){
    8000560a:	f9040713          	addi	a4,s0,-112
    8000560e:	84ce                	mv	s1,s3
    80005610:	bf41                	j	800055a0 <virtio_disk_rw+0x6a>
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];

  if(write)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    80005612:	20058713          	addi	a4,a1,512
    80005616:	00471693          	slli	a3,a4,0x4
    8000561a:	00019717          	auipc	a4,0x19
    8000561e:	9e670713          	addi	a4,a4,-1562 # 8001e000 <disk>
    80005622:	9736                	add	a4,a4,a3
    80005624:	4685                	li	a3,1
    80005626:	0ad72423          	sw	a3,168(a4)
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    8000562a:	20058713          	addi	a4,a1,512
    8000562e:	00471693          	slli	a3,a4,0x4
    80005632:	00019717          	auipc	a4,0x19
    80005636:	9ce70713          	addi	a4,a4,-1586 # 8001e000 <disk>
    8000563a:	9736                	add	a4,a4,a3
    8000563c:	0a072623          	sw	zero,172(a4)
  buf0->sector = sector;
    80005640:	0b973823          	sd	s9,176(a4)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80005644:	7679                	lui	a2,0xffffe
    80005646:	963e                	add	a2,a2,a5
    80005648:	0001b697          	auipc	a3,0x1b
    8000564c:	9b868693          	addi	a3,a3,-1608 # 80020000 <disk+0x2000>
    80005650:	6298                	ld	a4,0(a3)
    80005652:	9732                	add	a4,a4,a2
    80005654:	e308                	sd	a0,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80005656:	6298                	ld	a4,0(a3)
    80005658:	9732                	add	a4,a4,a2
    8000565a:	4541                	li	a0,16
    8000565c:	c708                	sw	a0,8(a4)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    8000565e:	6298                	ld	a4,0(a3)
    80005660:	9732                	add	a4,a4,a2
    80005662:	4505                	li	a0,1
    80005664:	00a71623          	sh	a0,12(a4)
  disk.desc[idx[0]].next = idx[1];
    80005668:	f9442703          	lw	a4,-108(s0)
    8000566c:	6288                	ld	a0,0(a3)
    8000566e:	962a                	add	a2,a2,a0
    80005670:	00e61723          	sh	a4,14(a2) # ffffffffffffe00e <end+0xffffffff7ffd2dc6>

  disk.desc[idx[1]].addr = (uint64) b->data;
    80005674:	0712                	slli	a4,a4,0x4
    80005676:	6290                	ld	a2,0(a3)
    80005678:	963a                	add	a2,a2,a4
    8000567a:	06090513          	addi	a0,s2,96
    8000567e:	e208                	sd	a0,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    80005680:	6294                	ld	a3,0(a3)
    80005682:	96ba                	add	a3,a3,a4
    80005684:	40000613          	li	a2,1024
    80005688:	c690                	sw	a2,8(a3)
  if(write)
    8000568a:	140d0063          	beqz	s10,800057ca <virtio_disk_rw+0x294>
    disk.desc[idx[1]].flags = 0; // device reads b->data
    8000568e:	0001b697          	auipc	a3,0x1b
    80005692:	9726b683          	ld	a3,-1678(a3) # 80020000 <disk+0x2000>
    80005696:	96ba                	add	a3,a3,a4
    80005698:	00069623          	sh	zero,12(a3)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    8000569c:	00019817          	auipc	a6,0x19
    800056a0:	96480813          	addi	a6,a6,-1692 # 8001e000 <disk>
    800056a4:	0001b517          	auipc	a0,0x1b
    800056a8:	95c50513          	addi	a0,a0,-1700 # 80020000 <disk+0x2000>
    800056ac:	6114                	ld	a3,0(a0)
    800056ae:	96ba                	add	a3,a3,a4
    800056b0:	00c6d603          	lhu	a2,12(a3)
    800056b4:	00166613          	ori	a2,a2,1
    800056b8:	00c69623          	sh	a2,12(a3)
  disk.desc[idx[1]].next = idx[2];
    800056bc:	f9842683          	lw	a3,-104(s0)
    800056c0:	6110                	ld	a2,0(a0)
    800056c2:	9732                	add	a4,a4,a2
    800056c4:	00d71723          	sh	a3,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    800056c8:	20058613          	addi	a2,a1,512
    800056cc:	0612                	slli	a2,a2,0x4
    800056ce:	9642                	add	a2,a2,a6
    800056d0:	577d                	li	a4,-1
    800056d2:	02e60823          	sb	a4,48(a2)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    800056d6:	00469713          	slli	a4,a3,0x4
    800056da:	6114                	ld	a3,0(a0)
    800056dc:	96ba                	add	a3,a3,a4
    800056de:	03078793          	addi	a5,a5,48
    800056e2:	97c2                	add	a5,a5,a6
    800056e4:	e29c                	sd	a5,0(a3)
  disk.desc[idx[2]].len = 1;
    800056e6:	611c                	ld	a5,0(a0)
    800056e8:	97ba                	add	a5,a5,a4
    800056ea:	4685                	li	a3,1
    800056ec:	c794                	sw	a3,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    800056ee:	611c                	ld	a5,0(a0)
    800056f0:	97ba                	add	a5,a5,a4
    800056f2:	4809                	li	a6,2
    800056f4:	01079623          	sh	a6,12(a5)
  disk.desc[idx[2]].next = 0;
    800056f8:	611c                	ld	a5,0(a0)
    800056fa:	973e                	add	a4,a4,a5
    800056fc:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80005700:	00d92223          	sw	a3,4(s2)
  disk.info[idx[0]].b = b;
    80005704:	03263423          	sd	s2,40(a2)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80005708:	6518                	ld	a4,8(a0)
    8000570a:	00275783          	lhu	a5,2(a4)
    8000570e:	8b9d                	andi	a5,a5,7
    80005710:	0786                	slli	a5,a5,0x1
    80005712:	97ba                	add	a5,a5,a4
    80005714:	00b79223          	sh	a1,4(a5)

  __sync_synchronize();
    80005718:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    8000571c:	6518                	ld	a4,8(a0)
    8000571e:	00275783          	lhu	a5,2(a4)
    80005722:	2785                	addiw	a5,a5,1
    80005724:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80005728:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    8000572c:	100017b7          	lui	a5,0x10001
    80005730:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80005734:	00492703          	lw	a4,4(s2)
    80005738:	4785                	li	a5,1
    8000573a:	02f71163          	bne	a4,a5,8000575c <virtio_disk_rw+0x226>
    sleep(b, &disk.vdisk_lock);
    8000573e:	0001b997          	auipc	s3,0x1b
    80005742:	9ea98993          	addi	s3,s3,-1558 # 80020128 <disk+0x2128>
  while(b->disk == 1) {
    80005746:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    80005748:	85ce                	mv	a1,s3
    8000574a:	854a                	mv	a0,s2
    8000574c:	ffffc097          	auipc	ra,0xffffc
    80005750:	ea6080e7          	jalr	-346(ra) # 800015f2 <sleep>
  while(b->disk == 1) {
    80005754:	00492783          	lw	a5,4(s2)
    80005758:	fe9788e3          	beq	a5,s1,80005748 <virtio_disk_rw+0x212>
  }

  disk.info[idx[0]].b = 0;
    8000575c:	f9042903          	lw	s2,-112(s0)
    80005760:	20090793          	addi	a5,s2,512
    80005764:	00479713          	slli	a4,a5,0x4
    80005768:	00019797          	auipc	a5,0x19
    8000576c:	89878793          	addi	a5,a5,-1896 # 8001e000 <disk>
    80005770:	97ba                	add	a5,a5,a4
    80005772:	0207b423          	sd	zero,40(a5)
    int flag = disk.desc[i].flags;
    80005776:	0001b997          	auipc	s3,0x1b
    8000577a:	88a98993          	addi	s3,s3,-1910 # 80020000 <disk+0x2000>
    8000577e:	00491713          	slli	a4,s2,0x4
    80005782:	0009b783          	ld	a5,0(s3)
    80005786:	97ba                	add	a5,a5,a4
    80005788:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    8000578c:	854a                	mv	a0,s2
    8000578e:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80005792:	00000097          	auipc	ra,0x0
    80005796:	bc4080e7          	jalr	-1084(ra) # 80005356 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    8000579a:	8885                	andi	s1,s1,1
    8000579c:	f0ed                	bnez	s1,8000577e <virtio_disk_rw+0x248>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    8000579e:	0001b517          	auipc	a0,0x1b
    800057a2:	98a50513          	addi	a0,a0,-1654 # 80020128 <disk+0x2128>
    800057a6:	00001097          	auipc	ra,0x1
    800057aa:	f8a080e7          	jalr	-118(ra) # 80006730 <release>
}
    800057ae:	70a6                	ld	ra,104(sp)
    800057b0:	7406                	ld	s0,96(sp)
    800057b2:	64e6                	ld	s1,88(sp)
    800057b4:	6946                	ld	s2,80(sp)
    800057b6:	69a6                	ld	s3,72(sp)
    800057b8:	6a06                	ld	s4,64(sp)
    800057ba:	7ae2                	ld	s5,56(sp)
    800057bc:	7b42                	ld	s6,48(sp)
    800057be:	7ba2                	ld	s7,40(sp)
    800057c0:	7c02                	ld	s8,32(sp)
    800057c2:	6ce2                	ld	s9,24(sp)
    800057c4:	6d42                	ld	s10,16(sp)
    800057c6:	6165                	addi	sp,sp,112
    800057c8:	8082                	ret
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    800057ca:	0001b697          	auipc	a3,0x1b
    800057ce:	8366b683          	ld	a3,-1994(a3) # 80020000 <disk+0x2000>
    800057d2:	96ba                	add	a3,a3,a4
    800057d4:	4609                	li	a2,2
    800057d6:	00c69623          	sh	a2,12(a3)
    800057da:	b5c9                	j	8000569c <virtio_disk_rw+0x166>
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800057dc:	f9042583          	lw	a1,-112(s0)
    800057e0:	20058793          	addi	a5,a1,512
    800057e4:	0792                	slli	a5,a5,0x4
    800057e6:	00019517          	auipc	a0,0x19
    800057ea:	8c250513          	addi	a0,a0,-1854 # 8001e0a8 <disk+0xa8>
    800057ee:	953e                	add	a0,a0,a5
  if(write)
    800057f0:	e20d11e3          	bnez	s10,80005612 <virtio_disk_rw+0xdc>
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
    800057f4:	20058713          	addi	a4,a1,512
    800057f8:	00471693          	slli	a3,a4,0x4
    800057fc:	00019717          	auipc	a4,0x19
    80005800:	80470713          	addi	a4,a4,-2044 # 8001e000 <disk>
    80005804:	9736                	add	a4,a4,a3
    80005806:	0a072423          	sw	zero,168(a4)
    8000580a:	b505                	j	8000562a <virtio_disk_rw+0xf4>

000000008000580c <virtio_disk_intr>:

void
virtio_disk_intr()
{
    8000580c:	1101                	addi	sp,sp,-32
    8000580e:	ec06                	sd	ra,24(sp)
    80005810:	e822                	sd	s0,16(sp)
    80005812:	e426                	sd	s1,8(sp)
    80005814:	e04a                	sd	s2,0(sp)
    80005816:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80005818:	0001b517          	auipc	a0,0x1b
    8000581c:	91050513          	addi	a0,a0,-1776 # 80020128 <disk+0x2128>
    80005820:	00001097          	auipc	ra,0x1
    80005824:	e40080e7          	jalr	-448(ra) # 80006660 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80005828:	10001737          	lui	a4,0x10001
    8000582c:	533c                	lw	a5,96(a4)
    8000582e:	8b8d                	andi	a5,a5,3
    80005830:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    80005832:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80005836:	0001a797          	auipc	a5,0x1a
    8000583a:	7ca78793          	addi	a5,a5,1994 # 80020000 <disk+0x2000>
    8000583e:	6b94                	ld	a3,16(a5)
    80005840:	0207d703          	lhu	a4,32(a5)
    80005844:	0026d783          	lhu	a5,2(a3)
    80005848:	06f70163          	beq	a4,a5,800058aa <virtio_disk_intr+0x9e>
    __sync_synchronize();
    int id = disk.used->ring[disk.used_idx % NUM].id;
    8000584c:	00018917          	auipc	s2,0x18
    80005850:	7b490913          	addi	s2,s2,1972 # 8001e000 <disk>
    80005854:	0001a497          	auipc	s1,0x1a
    80005858:	7ac48493          	addi	s1,s1,1964 # 80020000 <disk+0x2000>
    __sync_synchronize();
    8000585c:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80005860:	6898                	ld	a4,16(s1)
    80005862:	0204d783          	lhu	a5,32(s1)
    80005866:	8b9d                	andi	a5,a5,7
    80005868:	078e                	slli	a5,a5,0x3
    8000586a:	97ba                	add	a5,a5,a4
    8000586c:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    8000586e:	20078713          	addi	a4,a5,512
    80005872:	0712                	slli	a4,a4,0x4
    80005874:	974a                	add	a4,a4,s2
    80005876:	03074703          	lbu	a4,48(a4) # 10001030 <_entry-0x6fffefd0>
    8000587a:	e731                	bnez	a4,800058c6 <virtio_disk_intr+0xba>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    8000587c:	20078793          	addi	a5,a5,512
    80005880:	0792                	slli	a5,a5,0x4
    80005882:	97ca                	add	a5,a5,s2
    80005884:	7788                	ld	a0,40(a5)
    b->disk = 0;   // disk is done with buf
    80005886:	00052223          	sw	zero,4(a0)
    wakeup(b);
    8000588a:	ffffc097          	auipc	ra,0xffffc
    8000588e:	ef4080e7          	jalr	-268(ra) # 8000177e <wakeup>

    disk.used_idx += 1;
    80005892:	0204d783          	lhu	a5,32(s1)
    80005896:	2785                	addiw	a5,a5,1
    80005898:	17c2                	slli	a5,a5,0x30
    8000589a:	93c1                	srli	a5,a5,0x30
    8000589c:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    800058a0:	6898                	ld	a4,16(s1)
    800058a2:	00275703          	lhu	a4,2(a4)
    800058a6:	faf71be3          	bne	a4,a5,8000585c <virtio_disk_intr+0x50>
  }

  release(&disk.vdisk_lock);
    800058aa:	0001b517          	auipc	a0,0x1b
    800058ae:	87e50513          	addi	a0,a0,-1922 # 80020128 <disk+0x2128>
    800058b2:	00001097          	auipc	ra,0x1
    800058b6:	e7e080e7          	jalr	-386(ra) # 80006730 <release>
}
    800058ba:	60e2                	ld	ra,24(sp)
    800058bc:	6442                	ld	s0,16(sp)
    800058be:	64a2                	ld	s1,8(sp)
    800058c0:	6902                	ld	s2,0(sp)
    800058c2:	6105                	addi	sp,sp,32
    800058c4:	8082                	ret
      panic("virtio_disk_intr status");
    800058c6:	00003517          	auipc	a0,0x3
    800058ca:	eb250513          	addi	a0,a0,-334 # 80008778 <syscalls+0x3b0>
    800058ce:	00001097          	auipc	ra,0x1
    800058d2:	85e080e7          	jalr	-1954(ra) # 8000612c <panic>

00000000800058d6 <statswrite>:
int statscopyin(char*, int);
int statslock(char*, int);
  
int
statswrite(int user_src, uint64 src, int n)
{
    800058d6:	1141                	addi	sp,sp,-16
    800058d8:	e422                	sd	s0,8(sp)
    800058da:	0800                	addi	s0,sp,16
  return -1;
}
    800058dc:	557d                	li	a0,-1
    800058de:	6422                	ld	s0,8(sp)
    800058e0:	0141                	addi	sp,sp,16
    800058e2:	8082                	ret

00000000800058e4 <statsread>:

int
statsread(int user_dst, uint64 dst, int n)
{
    800058e4:	7179                	addi	sp,sp,-48
    800058e6:	f406                	sd	ra,40(sp)
    800058e8:	f022                	sd	s0,32(sp)
    800058ea:	ec26                	sd	s1,24(sp)
    800058ec:	e84a                	sd	s2,16(sp)
    800058ee:	e44e                	sd	s3,8(sp)
    800058f0:	e052                	sd	s4,0(sp)
    800058f2:	1800                	addi	s0,sp,48
    800058f4:	892a                	mv	s2,a0
    800058f6:	89ae                	mv	s3,a1
    800058f8:	84b2                	mv	s1,a2
  int m;

  acquire(&stats.lock);
    800058fa:	0001b517          	auipc	a0,0x1b
    800058fe:	70650513          	addi	a0,a0,1798 # 80021000 <stats>
    80005902:	00001097          	auipc	ra,0x1
    80005906:	d5e080e7          	jalr	-674(ra) # 80006660 <acquire>

  if(stats.sz == 0) {
    8000590a:	0001c797          	auipc	a5,0x1c
    8000590e:	7167a783          	lw	a5,1814(a5) # 80022020 <stats+0x1020>
    80005912:	cbb5                	beqz	a5,80005986 <statsread+0xa2>
#endif
#ifdef LAB_LOCK
    stats.sz = statslock(stats.buf, BUFSZ);
#endif
  }
  m = stats.sz - stats.off;
    80005914:	0001c797          	auipc	a5,0x1c
    80005918:	6ec78793          	addi	a5,a5,1772 # 80022000 <stats+0x1000>
    8000591c:	53d8                	lw	a4,36(a5)
    8000591e:	539c                	lw	a5,32(a5)
    80005920:	9f99                	subw	a5,a5,a4
    80005922:	0007869b          	sext.w	a3,a5

  if (m > 0) {
    80005926:	06d05e63          	blez	a3,800059a2 <statsread+0xbe>
    if(m > n)
    8000592a:	8a3e                	mv	s4,a5
    8000592c:	00d4d363          	bge	s1,a3,80005932 <statsread+0x4e>
    80005930:	8a26                	mv	s4,s1
    80005932:	000a049b          	sext.w	s1,s4
      m  = n;
    if(either_copyout(user_dst, dst, stats.buf+stats.off, m) != -1) {
    80005936:	86a6                	mv	a3,s1
    80005938:	0001b617          	auipc	a2,0x1b
    8000593c:	6e860613          	addi	a2,a2,1768 # 80021020 <stats+0x20>
    80005940:	963a                	add	a2,a2,a4
    80005942:	85ce                	mv	a1,s3
    80005944:	854a                	mv	a0,s2
    80005946:	ffffc097          	auipc	ra,0xffffc
    8000594a:	050080e7          	jalr	80(ra) # 80001996 <either_copyout>
    8000594e:	57fd                	li	a5,-1
    80005950:	00f50a63          	beq	a0,a5,80005964 <statsread+0x80>
      stats.off += m;
    80005954:	0001c717          	auipc	a4,0x1c
    80005958:	6ac70713          	addi	a4,a4,1708 # 80022000 <stats+0x1000>
    8000595c:	535c                	lw	a5,36(a4)
    8000595e:	014787bb          	addw	a5,a5,s4
    80005962:	d35c                	sw	a5,36(a4)
  } else {
    m = -1;
    stats.sz = 0;
    stats.off = 0;
  }
  release(&stats.lock);
    80005964:	0001b517          	auipc	a0,0x1b
    80005968:	69c50513          	addi	a0,a0,1692 # 80021000 <stats>
    8000596c:	00001097          	auipc	ra,0x1
    80005970:	dc4080e7          	jalr	-572(ra) # 80006730 <release>
  return m;
}
    80005974:	8526                	mv	a0,s1
    80005976:	70a2                	ld	ra,40(sp)
    80005978:	7402                	ld	s0,32(sp)
    8000597a:	64e2                	ld	s1,24(sp)
    8000597c:	6942                	ld	s2,16(sp)
    8000597e:	69a2                	ld	s3,8(sp)
    80005980:	6a02                	ld	s4,0(sp)
    80005982:	6145                	addi	sp,sp,48
    80005984:	8082                	ret
    stats.sz = statslock(stats.buf, BUFSZ);
    80005986:	6585                	lui	a1,0x1
    80005988:	0001b517          	auipc	a0,0x1b
    8000598c:	69850513          	addi	a0,a0,1688 # 80021020 <stats+0x20>
    80005990:	00001097          	auipc	ra,0x1
    80005994:	f28080e7          	jalr	-216(ra) # 800068b8 <statslock>
    80005998:	0001c797          	auipc	a5,0x1c
    8000599c:	68a7a423          	sw	a0,1672(a5) # 80022020 <stats+0x1020>
    800059a0:	bf95                	j	80005914 <statsread+0x30>
    stats.sz = 0;
    800059a2:	0001c797          	auipc	a5,0x1c
    800059a6:	65e78793          	addi	a5,a5,1630 # 80022000 <stats+0x1000>
    800059aa:	0207a023          	sw	zero,32(a5)
    stats.off = 0;
    800059ae:	0207a223          	sw	zero,36(a5)
    m = -1;
    800059b2:	54fd                	li	s1,-1
    800059b4:	bf45                	j	80005964 <statsread+0x80>

00000000800059b6 <statsinit>:

void
statsinit(void)
{
    800059b6:	1141                	addi	sp,sp,-16
    800059b8:	e406                	sd	ra,8(sp)
    800059ba:	e022                	sd	s0,0(sp)
    800059bc:	0800                	addi	s0,sp,16
  initlock(&stats.lock, "stats");
    800059be:	00003597          	auipc	a1,0x3
    800059c2:	dd258593          	addi	a1,a1,-558 # 80008790 <syscalls+0x3c8>
    800059c6:	0001b517          	auipc	a0,0x1b
    800059ca:	63a50513          	addi	a0,a0,1594 # 80021000 <stats>
    800059ce:	00001097          	auipc	ra,0x1
    800059d2:	e0e080e7          	jalr	-498(ra) # 800067dc <initlock>

  devsw[STATS].read = statsread;
    800059d6:	00017797          	auipc	a5,0x17
    800059da:	42278793          	addi	a5,a5,1058 # 8001cdf8 <devsw>
    800059de:	00000717          	auipc	a4,0x0
    800059e2:	f0670713          	addi	a4,a4,-250 # 800058e4 <statsread>
    800059e6:	f398                	sd	a4,32(a5)
  devsw[STATS].write = statswrite;
    800059e8:	00000717          	auipc	a4,0x0
    800059ec:	eee70713          	addi	a4,a4,-274 # 800058d6 <statswrite>
    800059f0:	f798                	sd	a4,40(a5)
}
    800059f2:	60a2                	ld	ra,8(sp)
    800059f4:	6402                	ld	s0,0(sp)
    800059f6:	0141                	addi	sp,sp,16
    800059f8:	8082                	ret

00000000800059fa <sprintint>:
  return 1;
}

static int
sprintint(char *s, int xx, int base, int sign)
{
    800059fa:	1101                	addi	sp,sp,-32
    800059fc:	ec22                	sd	s0,24(sp)
    800059fe:	1000                	addi	s0,sp,32
    80005a00:	882a                	mv	a6,a0
  char buf[16];
  int i, n;
  uint x;

  if(sign && (sign = xx < 0))
    80005a02:	c299                	beqz	a3,80005a08 <sprintint+0xe>
    80005a04:	0805c163          	bltz	a1,80005a86 <sprintint+0x8c>
    x = -xx;
  else
    x = xx;
    80005a08:	2581                	sext.w	a1,a1
    80005a0a:	4301                	li	t1,0

  i = 0;
    80005a0c:	fe040713          	addi	a4,s0,-32
    80005a10:	4501                	li	a0,0
  do {
    buf[i++] = digits[x % base];
    80005a12:	2601                	sext.w	a2,a2
    80005a14:	00003697          	auipc	a3,0x3
    80005a18:	d9c68693          	addi	a3,a3,-612 # 800087b0 <digits>
    80005a1c:	88aa                	mv	a7,a0
    80005a1e:	2505                	addiw	a0,a0,1
    80005a20:	02c5f7bb          	remuw	a5,a1,a2
    80005a24:	1782                	slli	a5,a5,0x20
    80005a26:	9381                	srli	a5,a5,0x20
    80005a28:	97b6                	add	a5,a5,a3
    80005a2a:	0007c783          	lbu	a5,0(a5)
    80005a2e:	00f70023          	sb	a5,0(a4)
  } while((x /= base) != 0);
    80005a32:	0005879b          	sext.w	a5,a1
    80005a36:	02c5d5bb          	divuw	a1,a1,a2
    80005a3a:	0705                	addi	a4,a4,1
    80005a3c:	fec7f0e3          	bgeu	a5,a2,80005a1c <sprintint+0x22>

  if(sign)
    80005a40:	00030b63          	beqz	t1,80005a56 <sprintint+0x5c>
    buf[i++] = '-';
    80005a44:	ff040793          	addi	a5,s0,-16
    80005a48:	97aa                	add	a5,a5,a0
    80005a4a:	02d00713          	li	a4,45
    80005a4e:	fee78823          	sb	a4,-16(a5)
    80005a52:	0028851b          	addiw	a0,a7,2

  n = 0;
  while(--i >= 0)
    80005a56:	02a05c63          	blez	a0,80005a8e <sprintint+0x94>
    80005a5a:	fe040793          	addi	a5,s0,-32
    80005a5e:	00a78733          	add	a4,a5,a0
    80005a62:	87c2                	mv	a5,a6
    80005a64:	0805                	addi	a6,a6,1
    80005a66:	fff5061b          	addiw	a2,a0,-1
    80005a6a:	1602                	slli	a2,a2,0x20
    80005a6c:	9201                	srli	a2,a2,0x20
    80005a6e:	9642                	add	a2,a2,a6
  *s = c;
    80005a70:	fff74683          	lbu	a3,-1(a4)
    80005a74:	00d78023          	sb	a3,0(a5)
  while(--i >= 0)
    80005a78:	177d                	addi	a4,a4,-1
    80005a7a:	0785                	addi	a5,a5,1
    80005a7c:	fec79ae3          	bne	a5,a2,80005a70 <sprintint+0x76>
    n += sputc(s+n, buf[i]);
  return n;
}
    80005a80:	6462                	ld	s0,24(sp)
    80005a82:	6105                	addi	sp,sp,32
    80005a84:	8082                	ret
    x = -xx;
    80005a86:	40b005bb          	negw	a1,a1
  if(sign && (sign = xx < 0))
    80005a8a:	4305                	li	t1,1
    x = -xx;
    80005a8c:	b741                	j	80005a0c <sprintint+0x12>
  while(--i >= 0)
    80005a8e:	4501                	li	a0,0
    80005a90:	bfc5                	j	80005a80 <sprintint+0x86>

0000000080005a92 <snprintf>:

int
snprintf(char *buf, int sz, char *fmt, ...)
{
    80005a92:	7171                	addi	sp,sp,-176
    80005a94:	fc86                	sd	ra,120(sp)
    80005a96:	f8a2                	sd	s0,112(sp)
    80005a98:	f4a6                	sd	s1,104(sp)
    80005a9a:	f0ca                	sd	s2,96(sp)
    80005a9c:	ecce                	sd	s3,88(sp)
    80005a9e:	e8d2                	sd	s4,80(sp)
    80005aa0:	e4d6                	sd	s5,72(sp)
    80005aa2:	e0da                	sd	s6,64(sp)
    80005aa4:	fc5e                	sd	s7,56(sp)
    80005aa6:	f862                	sd	s8,48(sp)
    80005aa8:	f466                	sd	s9,40(sp)
    80005aaa:	f06a                	sd	s10,32(sp)
    80005aac:	ec6e                	sd	s11,24(sp)
    80005aae:	0100                	addi	s0,sp,128
    80005ab0:	e414                	sd	a3,8(s0)
    80005ab2:	e818                	sd	a4,16(s0)
    80005ab4:	ec1c                	sd	a5,24(s0)
    80005ab6:	03043023          	sd	a6,32(s0)
    80005aba:	03143423          	sd	a7,40(s0)
  va_list ap;
  int i, c;
  int off = 0;
  char *s;

  if (fmt == 0)
    80005abe:	ca0d                	beqz	a2,80005af0 <snprintf+0x5e>
    80005ac0:	8baa                	mv	s7,a0
    80005ac2:	89ae                	mv	s3,a1
    80005ac4:	8a32                	mv	s4,a2
    panic("null fmt");

  va_start(ap, fmt);
    80005ac6:	00840793          	addi	a5,s0,8
    80005aca:	f8f43423          	sd	a5,-120(s0)
  int off = 0;
    80005ace:	4481                	li	s1,0
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
    80005ad0:	4901                	li	s2,0
    80005ad2:	02b05763          	blez	a1,80005b00 <snprintf+0x6e>
    if(c != '%'){
    80005ad6:	02500a93          	li	s5,37
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    80005ada:	07300b13          	li	s6,115
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
      break;
    case 's':
      if((s = va_arg(ap, char*)) == 0)
        s = "(null)";
      for(; *s && off < sz; s++)
    80005ade:	02800d93          	li	s11,40
  *s = c;
    80005ae2:	02500d13          	li	s10,37
    switch(c){
    80005ae6:	07800c93          	li	s9,120
    80005aea:	06400c13          	li	s8,100
    80005aee:	a01d                	j	80005b14 <snprintf+0x82>
    panic("null fmt");
    80005af0:	00003517          	auipc	a0,0x3
    80005af4:	cb050513          	addi	a0,a0,-848 # 800087a0 <syscalls+0x3d8>
    80005af8:	00000097          	auipc	ra,0x0
    80005afc:	634080e7          	jalr	1588(ra) # 8000612c <panic>
  int off = 0;
    80005b00:	4481                	li	s1,0
    80005b02:	a86d                	j	80005bbc <snprintf+0x12a>
  *s = c;
    80005b04:	009b8733          	add	a4,s7,s1
    80005b08:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
    80005b0c:	2485                	addiw	s1,s1,1
  for(i = 0; off < sz && (c = fmt[i] & 0xff) != 0; i++){
    80005b0e:	2905                	addiw	s2,s2,1
    80005b10:	0b34d663          	bge	s1,s3,80005bbc <snprintf+0x12a>
    80005b14:	012a07b3          	add	a5,s4,s2
    80005b18:	0007c783          	lbu	a5,0(a5)
    80005b1c:	0007871b          	sext.w	a4,a5
    80005b20:	cfd1                	beqz	a5,80005bbc <snprintf+0x12a>
    if(c != '%'){
    80005b22:	ff5711e3          	bne	a4,s5,80005b04 <snprintf+0x72>
    c = fmt[++i] & 0xff;
    80005b26:	2905                	addiw	s2,s2,1
    80005b28:	012a07b3          	add	a5,s4,s2
    80005b2c:	0007c783          	lbu	a5,0(a5)
    if(c == 0)
    80005b30:	c7d1                	beqz	a5,80005bbc <snprintf+0x12a>
    switch(c){
    80005b32:	05678c63          	beq	a5,s6,80005b8a <snprintf+0xf8>
    80005b36:	02fb6763          	bltu	s6,a5,80005b64 <snprintf+0xd2>
    80005b3a:	0b578763          	beq	a5,s5,80005be8 <snprintf+0x156>
    80005b3e:	0b879b63          	bne	a5,s8,80005bf4 <snprintf+0x162>
      off += sprintint(buf+off, va_arg(ap, int), 10, 1);
    80005b42:	f8843783          	ld	a5,-120(s0)
    80005b46:	00878713          	addi	a4,a5,8
    80005b4a:	f8e43423          	sd	a4,-120(s0)
    80005b4e:	4685                	li	a3,1
    80005b50:	4629                	li	a2,10
    80005b52:	438c                	lw	a1,0(a5)
    80005b54:	009b8533          	add	a0,s7,s1
    80005b58:	00000097          	auipc	ra,0x0
    80005b5c:	ea2080e7          	jalr	-350(ra) # 800059fa <sprintint>
    80005b60:	9ca9                	addw	s1,s1,a0
      break;
    80005b62:	b775                	j	80005b0e <snprintf+0x7c>
    switch(c){
    80005b64:	09979863          	bne	a5,s9,80005bf4 <snprintf+0x162>
      off += sprintint(buf+off, va_arg(ap, int), 16, 1);
    80005b68:	f8843783          	ld	a5,-120(s0)
    80005b6c:	00878713          	addi	a4,a5,8
    80005b70:	f8e43423          	sd	a4,-120(s0)
    80005b74:	4685                	li	a3,1
    80005b76:	4641                	li	a2,16
    80005b78:	438c                	lw	a1,0(a5)
    80005b7a:	009b8533          	add	a0,s7,s1
    80005b7e:	00000097          	auipc	ra,0x0
    80005b82:	e7c080e7          	jalr	-388(ra) # 800059fa <sprintint>
    80005b86:	9ca9                	addw	s1,s1,a0
      break;
    80005b88:	b759                	j	80005b0e <snprintf+0x7c>
      if((s = va_arg(ap, char*)) == 0)
    80005b8a:	f8843783          	ld	a5,-120(s0)
    80005b8e:	00878713          	addi	a4,a5,8
    80005b92:	f8e43423          	sd	a4,-120(s0)
    80005b96:	639c                	ld	a5,0(a5)
    80005b98:	c3b1                	beqz	a5,80005bdc <snprintf+0x14a>
      for(; *s && off < sz; s++)
    80005b9a:	0007c703          	lbu	a4,0(a5)
    80005b9e:	db25                	beqz	a4,80005b0e <snprintf+0x7c>
    80005ba0:	0134de63          	bge	s1,s3,80005bbc <snprintf+0x12a>
    80005ba4:	009b86b3          	add	a3,s7,s1
  *s = c;
    80005ba8:	00e68023          	sb	a4,0(a3)
        off += sputc(buf+off, *s);
    80005bac:	2485                	addiw	s1,s1,1
      for(; *s && off < sz; s++)
    80005bae:	0785                	addi	a5,a5,1
    80005bb0:	0007c703          	lbu	a4,0(a5)
    80005bb4:	df29                	beqz	a4,80005b0e <snprintf+0x7c>
    80005bb6:	0685                	addi	a3,a3,1
    80005bb8:	fe9998e3          	bne	s3,s1,80005ba8 <snprintf+0x116>
      off += sputc(buf+off, c);
      break;
    }
  }
  return off;
}
    80005bbc:	8526                	mv	a0,s1
    80005bbe:	70e6                	ld	ra,120(sp)
    80005bc0:	7446                	ld	s0,112(sp)
    80005bc2:	74a6                	ld	s1,104(sp)
    80005bc4:	7906                	ld	s2,96(sp)
    80005bc6:	69e6                	ld	s3,88(sp)
    80005bc8:	6a46                	ld	s4,80(sp)
    80005bca:	6aa6                	ld	s5,72(sp)
    80005bcc:	6b06                	ld	s6,64(sp)
    80005bce:	7be2                	ld	s7,56(sp)
    80005bd0:	7c42                	ld	s8,48(sp)
    80005bd2:	7ca2                	ld	s9,40(sp)
    80005bd4:	7d02                	ld	s10,32(sp)
    80005bd6:	6de2                	ld	s11,24(sp)
    80005bd8:	614d                	addi	sp,sp,176
    80005bda:	8082                	ret
        s = "(null)";
    80005bdc:	00003797          	auipc	a5,0x3
    80005be0:	bbc78793          	addi	a5,a5,-1092 # 80008798 <syscalls+0x3d0>
      for(; *s && off < sz; s++)
    80005be4:	876e                	mv	a4,s11
    80005be6:	bf6d                	j	80005ba0 <snprintf+0x10e>
  *s = c;
    80005be8:	009b87b3          	add	a5,s7,s1
    80005bec:	01a78023          	sb	s10,0(a5)
      off += sputc(buf+off, '%');
    80005bf0:	2485                	addiw	s1,s1,1
      break;
    80005bf2:	bf31                	j	80005b0e <snprintf+0x7c>
  *s = c;
    80005bf4:	009b8733          	add	a4,s7,s1
    80005bf8:	01a70023          	sb	s10,0(a4)
      off += sputc(buf+off, c);
    80005bfc:	0014871b          	addiw	a4,s1,1
  *s = c;
    80005c00:	975e                	add	a4,a4,s7
    80005c02:	00f70023          	sb	a5,0(a4)
      off += sputc(buf+off, c);
    80005c06:	2489                	addiw	s1,s1,2
      break;
    80005c08:	b719                	j	80005b0e <snprintf+0x7c>

0000000080005c0a <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    80005c0a:	1141                	addi	sp,sp,-16
    80005c0c:	e422                	sd	s0,8(sp)
    80005c0e:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005c10:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80005c14:	0007869b          	sext.w	a3,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    80005c18:	0037979b          	slliw	a5,a5,0x3
    80005c1c:	02004737          	lui	a4,0x2004
    80005c20:	97ba                	add	a5,a5,a4
    80005c22:	0200c737          	lui	a4,0x200c
    80005c26:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005c2a:	000f4637          	lui	a2,0xf4
    80005c2e:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005c32:	95b2                	add	a1,a1,a2
    80005c34:	e38c                	sd	a1,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80005c36:	00269713          	slli	a4,a3,0x2
    80005c3a:	9736                	add	a4,a4,a3
    80005c3c:	00371693          	slli	a3,a4,0x3
    80005c40:	0001c717          	auipc	a4,0x1c
    80005c44:	3f070713          	addi	a4,a4,1008 # 80022030 <timer_scratch>
    80005c48:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    80005c4a:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    80005c4c:	f310                	sd	a2,32(a4)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80005c4e:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80005c52:	fffff797          	auipc	a5,0xfffff
    80005c56:	63e78793          	addi	a5,a5,1598 # 80005290 <timervec>
    80005c5a:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005c5e:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80005c62:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005c66:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    80005c6a:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80005c6e:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80005c72:	30479073          	csrw	mie,a5
}
    80005c76:	6422                	ld	s0,8(sp)
    80005c78:	0141                	addi	sp,sp,16
    80005c7a:	8082                	ret

0000000080005c7c <start>:
{
    80005c7c:	1141                	addi	sp,sp,-16
    80005c7e:	e406                	sd	ra,8(sp)
    80005c80:	e022                	sd	s0,0(sp)
    80005c82:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005c84:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80005c88:	7779                	lui	a4,0xffffe
    80005c8a:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffd35b7>
    80005c8e:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80005c90:	6705                	lui	a4,0x1
    80005c92:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005c96:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005c98:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80005c9c:	ffffa797          	auipc	a5,0xffffa
    80005ca0:	76878793          	addi	a5,a5,1896 # 80000404 <main>
    80005ca4:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80005ca8:	4781                	li	a5,0
    80005caa:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80005cae:	67c1                	lui	a5,0x10
    80005cb0:	17fd                	addi	a5,a5,-1
    80005cb2:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80005cb6:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80005cba:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80005cbe:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80005cc2:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80005cc6:	57fd                	li	a5,-1
    80005cc8:	83a9                	srli	a5,a5,0xa
    80005cca:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80005cce:	47bd                	li	a5,15
    80005cd0:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    80005cd4:	00000097          	auipc	ra,0x0
    80005cd8:	f36080e7          	jalr	-202(ra) # 80005c0a <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005cdc:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80005ce0:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80005ce2:	823e                	mv	tp,a5
  asm volatile("mret");
    80005ce4:	30200073          	mret
}
    80005ce8:	60a2                	ld	ra,8(sp)
    80005cea:	6402                	ld	s0,0(sp)
    80005cec:	0141                	addi	sp,sp,16
    80005cee:	8082                	ret

0000000080005cf0 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80005cf0:	715d                	addi	sp,sp,-80
    80005cf2:	e486                	sd	ra,72(sp)
    80005cf4:	e0a2                	sd	s0,64(sp)
    80005cf6:	fc26                	sd	s1,56(sp)
    80005cf8:	f84a                	sd	s2,48(sp)
    80005cfa:	f44e                	sd	s3,40(sp)
    80005cfc:	f052                	sd	s4,32(sp)
    80005cfe:	ec56                	sd	s5,24(sp)
    80005d00:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80005d02:	04c05663          	blez	a2,80005d4e <consolewrite+0x5e>
    80005d06:	8a2a                	mv	s4,a0
    80005d08:	84ae                	mv	s1,a1
    80005d0a:	89b2                	mv	s3,a2
    80005d0c:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80005d0e:	5afd                	li	s5,-1
    80005d10:	4685                	li	a3,1
    80005d12:	8626                	mv	a2,s1
    80005d14:	85d2                	mv	a1,s4
    80005d16:	fbf40513          	addi	a0,s0,-65
    80005d1a:	ffffc097          	auipc	ra,0xffffc
    80005d1e:	cd2080e7          	jalr	-814(ra) # 800019ec <either_copyin>
    80005d22:	01550c63          	beq	a0,s5,80005d3a <consolewrite+0x4a>
      break;
    uartputc(c);
    80005d26:	fbf44503          	lbu	a0,-65(s0)
    80005d2a:	00000097          	auipc	ra,0x0
    80005d2e:	78e080e7          	jalr	1934(ra) # 800064b8 <uartputc>
  for(i = 0; i < n; i++){
    80005d32:	2905                	addiw	s2,s2,1
    80005d34:	0485                	addi	s1,s1,1
    80005d36:	fd299de3          	bne	s3,s2,80005d10 <consolewrite+0x20>
  }

  return i;
}
    80005d3a:	854a                	mv	a0,s2
    80005d3c:	60a6                	ld	ra,72(sp)
    80005d3e:	6406                	ld	s0,64(sp)
    80005d40:	74e2                	ld	s1,56(sp)
    80005d42:	7942                	ld	s2,48(sp)
    80005d44:	79a2                	ld	s3,40(sp)
    80005d46:	7a02                	ld	s4,32(sp)
    80005d48:	6ae2                	ld	s5,24(sp)
    80005d4a:	6161                	addi	sp,sp,80
    80005d4c:	8082                	ret
  for(i = 0; i < n; i++){
    80005d4e:	4901                	li	s2,0
    80005d50:	b7ed                	j	80005d3a <consolewrite+0x4a>

0000000080005d52 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80005d52:	7119                	addi	sp,sp,-128
    80005d54:	fc86                	sd	ra,120(sp)
    80005d56:	f8a2                	sd	s0,112(sp)
    80005d58:	f4a6                	sd	s1,104(sp)
    80005d5a:	f0ca                	sd	s2,96(sp)
    80005d5c:	ecce                	sd	s3,88(sp)
    80005d5e:	e8d2                	sd	s4,80(sp)
    80005d60:	e4d6                	sd	s5,72(sp)
    80005d62:	e0da                	sd	s6,64(sp)
    80005d64:	fc5e                	sd	s7,56(sp)
    80005d66:	f862                	sd	s8,48(sp)
    80005d68:	f466                	sd	s9,40(sp)
    80005d6a:	f06a                	sd	s10,32(sp)
    80005d6c:	ec6e                	sd	s11,24(sp)
    80005d6e:	0100                	addi	s0,sp,128
    80005d70:	8b2a                	mv	s6,a0
    80005d72:	8aae                	mv	s5,a1
    80005d74:	8a32                	mv	s4,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80005d76:	00060b9b          	sext.w	s7,a2
  acquire(&cons.lock);
    80005d7a:	00024517          	auipc	a0,0x24
    80005d7e:	3f650513          	addi	a0,a0,1014 # 8002a170 <cons>
    80005d82:	00001097          	auipc	ra,0x1
    80005d86:	8de080e7          	jalr	-1826(ra) # 80006660 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80005d8a:	00024497          	auipc	s1,0x24
    80005d8e:	3e648493          	addi	s1,s1,998 # 8002a170 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80005d92:	89a6                	mv	s3,s1
    80005d94:	00024917          	auipc	s2,0x24
    80005d98:	47c90913          	addi	s2,s2,1148 # 8002a210 <cons+0xa0>
    }

    c = cons.buf[cons.r++ % INPUT_BUF];

    if(c == C('D')){  // end-of-file
    80005d9c:	4c91                	li	s9,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005d9e:	5d7d                	li	s10,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    80005da0:	4da9                	li	s11,10
  while(n > 0){
    80005da2:	07405863          	blez	s4,80005e12 <consoleread+0xc0>
    while(cons.r == cons.w){
    80005da6:	0a04a783          	lw	a5,160(s1)
    80005daa:	0a44a703          	lw	a4,164(s1)
    80005dae:	02f71463          	bne	a4,a5,80005dd6 <consoleread+0x84>
      if(myproc()->killed){
    80005db2:	ffffb097          	auipc	ra,0xffffb
    80005db6:	184080e7          	jalr	388(ra) # 80000f36 <myproc>
    80005dba:	591c                	lw	a5,48(a0)
    80005dbc:	e7b5                	bnez	a5,80005e28 <consoleread+0xd6>
      sleep(&cons.r, &cons.lock);
    80005dbe:	85ce                	mv	a1,s3
    80005dc0:	854a                	mv	a0,s2
    80005dc2:	ffffc097          	auipc	ra,0xffffc
    80005dc6:	830080e7          	jalr	-2000(ra) # 800015f2 <sleep>
    while(cons.r == cons.w){
    80005dca:	0a04a783          	lw	a5,160(s1)
    80005dce:	0a44a703          	lw	a4,164(s1)
    80005dd2:	fef700e3          	beq	a4,a5,80005db2 <consoleread+0x60>
    c = cons.buf[cons.r++ % INPUT_BUF];
    80005dd6:	0017871b          	addiw	a4,a5,1
    80005dda:	0ae4a023          	sw	a4,160(s1)
    80005dde:	07f7f713          	andi	a4,a5,127
    80005de2:	9726                	add	a4,a4,s1
    80005de4:	02074703          	lbu	a4,32(a4)
    80005de8:	00070c1b          	sext.w	s8,a4
    if(c == C('D')){  // end-of-file
    80005dec:	079c0663          	beq	s8,s9,80005e58 <consoleread+0x106>
    cbuf = c;
    80005df0:	f8e407a3          	sb	a4,-113(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005df4:	4685                	li	a3,1
    80005df6:	f8f40613          	addi	a2,s0,-113
    80005dfa:	85d6                	mv	a1,s5
    80005dfc:	855a                	mv	a0,s6
    80005dfe:	ffffc097          	auipc	ra,0xffffc
    80005e02:	b98080e7          	jalr	-1128(ra) # 80001996 <either_copyout>
    80005e06:	01a50663          	beq	a0,s10,80005e12 <consoleread+0xc0>
    dst++;
    80005e0a:	0a85                	addi	s5,s5,1
    --n;
    80005e0c:	3a7d                	addiw	s4,s4,-1
    if(c == '\n'){
    80005e0e:	f9bc1ae3          	bne	s8,s11,80005da2 <consoleread+0x50>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80005e12:	00024517          	auipc	a0,0x24
    80005e16:	35e50513          	addi	a0,a0,862 # 8002a170 <cons>
    80005e1a:	00001097          	auipc	ra,0x1
    80005e1e:	916080e7          	jalr	-1770(ra) # 80006730 <release>

  return target - n;
    80005e22:	414b853b          	subw	a0,s7,s4
    80005e26:	a811                	j	80005e3a <consoleread+0xe8>
        release(&cons.lock);
    80005e28:	00024517          	auipc	a0,0x24
    80005e2c:	34850513          	addi	a0,a0,840 # 8002a170 <cons>
    80005e30:	00001097          	auipc	ra,0x1
    80005e34:	900080e7          	jalr	-1792(ra) # 80006730 <release>
        return -1;
    80005e38:	557d                	li	a0,-1
}
    80005e3a:	70e6                	ld	ra,120(sp)
    80005e3c:	7446                	ld	s0,112(sp)
    80005e3e:	74a6                	ld	s1,104(sp)
    80005e40:	7906                	ld	s2,96(sp)
    80005e42:	69e6                	ld	s3,88(sp)
    80005e44:	6a46                	ld	s4,80(sp)
    80005e46:	6aa6                	ld	s5,72(sp)
    80005e48:	6b06                	ld	s6,64(sp)
    80005e4a:	7be2                	ld	s7,56(sp)
    80005e4c:	7c42                	ld	s8,48(sp)
    80005e4e:	7ca2                	ld	s9,40(sp)
    80005e50:	7d02                	ld	s10,32(sp)
    80005e52:	6de2                	ld	s11,24(sp)
    80005e54:	6109                	addi	sp,sp,128
    80005e56:	8082                	ret
      if(n < target){
    80005e58:	000a071b          	sext.w	a4,s4
    80005e5c:	fb777be3          	bgeu	a4,s7,80005e12 <consoleread+0xc0>
        cons.r--;
    80005e60:	00024717          	auipc	a4,0x24
    80005e64:	3af72823          	sw	a5,944(a4) # 8002a210 <cons+0xa0>
    80005e68:	b76d                	j	80005e12 <consoleread+0xc0>

0000000080005e6a <consputc>:
{
    80005e6a:	1141                	addi	sp,sp,-16
    80005e6c:	e406                	sd	ra,8(sp)
    80005e6e:	e022                	sd	s0,0(sp)
    80005e70:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80005e72:	10000793          	li	a5,256
    80005e76:	00f50a63          	beq	a0,a5,80005e8a <consputc+0x20>
    uartputc_sync(c);
    80005e7a:	00000097          	auipc	ra,0x0
    80005e7e:	564080e7          	jalr	1380(ra) # 800063de <uartputc_sync>
}
    80005e82:	60a2                	ld	ra,8(sp)
    80005e84:	6402                	ld	s0,0(sp)
    80005e86:	0141                	addi	sp,sp,16
    80005e88:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80005e8a:	4521                	li	a0,8
    80005e8c:	00000097          	auipc	ra,0x0
    80005e90:	552080e7          	jalr	1362(ra) # 800063de <uartputc_sync>
    80005e94:	02000513          	li	a0,32
    80005e98:	00000097          	auipc	ra,0x0
    80005e9c:	546080e7          	jalr	1350(ra) # 800063de <uartputc_sync>
    80005ea0:	4521                	li	a0,8
    80005ea2:	00000097          	auipc	ra,0x0
    80005ea6:	53c080e7          	jalr	1340(ra) # 800063de <uartputc_sync>
    80005eaa:	bfe1                	j	80005e82 <consputc+0x18>

0000000080005eac <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80005eac:	1101                	addi	sp,sp,-32
    80005eae:	ec06                	sd	ra,24(sp)
    80005eb0:	e822                	sd	s0,16(sp)
    80005eb2:	e426                	sd	s1,8(sp)
    80005eb4:	e04a                	sd	s2,0(sp)
    80005eb6:	1000                	addi	s0,sp,32
    80005eb8:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80005eba:	00024517          	auipc	a0,0x24
    80005ebe:	2b650513          	addi	a0,a0,694 # 8002a170 <cons>
    80005ec2:	00000097          	auipc	ra,0x0
    80005ec6:	79e080e7          	jalr	1950(ra) # 80006660 <acquire>

  switch(c){
    80005eca:	47d5                	li	a5,21
    80005ecc:	0af48663          	beq	s1,a5,80005f78 <consoleintr+0xcc>
    80005ed0:	0297ca63          	blt	a5,s1,80005f04 <consoleintr+0x58>
    80005ed4:	47a1                	li	a5,8
    80005ed6:	0ef48763          	beq	s1,a5,80005fc4 <consoleintr+0x118>
    80005eda:	47c1                	li	a5,16
    80005edc:	10f49a63          	bne	s1,a5,80005ff0 <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    80005ee0:	ffffc097          	auipc	ra,0xffffc
    80005ee4:	b62080e7          	jalr	-1182(ra) # 80001a42 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80005ee8:	00024517          	auipc	a0,0x24
    80005eec:	28850513          	addi	a0,a0,648 # 8002a170 <cons>
    80005ef0:	00001097          	auipc	ra,0x1
    80005ef4:	840080e7          	jalr	-1984(ra) # 80006730 <release>
}
    80005ef8:	60e2                	ld	ra,24(sp)
    80005efa:	6442                	ld	s0,16(sp)
    80005efc:	64a2                	ld	s1,8(sp)
    80005efe:	6902                	ld	s2,0(sp)
    80005f00:	6105                	addi	sp,sp,32
    80005f02:	8082                	ret
  switch(c){
    80005f04:	07f00793          	li	a5,127
    80005f08:	0af48e63          	beq	s1,a5,80005fc4 <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80005f0c:	00024717          	auipc	a4,0x24
    80005f10:	26470713          	addi	a4,a4,612 # 8002a170 <cons>
    80005f14:	0a872783          	lw	a5,168(a4)
    80005f18:	0a072703          	lw	a4,160(a4)
    80005f1c:	9f99                	subw	a5,a5,a4
    80005f1e:	07f00713          	li	a4,127
    80005f22:	fcf763e3          	bltu	a4,a5,80005ee8 <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    80005f26:	47b5                	li	a5,13
    80005f28:	0cf48763          	beq	s1,a5,80005ff6 <consoleintr+0x14a>
      consputc(c);
    80005f2c:	8526                	mv	a0,s1
    80005f2e:	00000097          	auipc	ra,0x0
    80005f32:	f3c080e7          	jalr	-196(ra) # 80005e6a <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80005f36:	00024797          	auipc	a5,0x24
    80005f3a:	23a78793          	addi	a5,a5,570 # 8002a170 <cons>
    80005f3e:	0a87a703          	lw	a4,168(a5)
    80005f42:	0017069b          	addiw	a3,a4,1
    80005f46:	0006861b          	sext.w	a2,a3
    80005f4a:	0ad7a423          	sw	a3,168(a5)
    80005f4e:	07f77713          	andi	a4,a4,127
    80005f52:	97ba                	add	a5,a5,a4
    80005f54:	02978023          	sb	s1,32(a5)
      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    80005f58:	47a9                	li	a5,10
    80005f5a:	0cf48563          	beq	s1,a5,80006024 <consoleintr+0x178>
    80005f5e:	4791                	li	a5,4
    80005f60:	0cf48263          	beq	s1,a5,80006024 <consoleintr+0x178>
    80005f64:	00024797          	auipc	a5,0x24
    80005f68:	2ac7a783          	lw	a5,684(a5) # 8002a210 <cons+0xa0>
    80005f6c:	0807879b          	addiw	a5,a5,128
    80005f70:	f6f61ce3          	bne	a2,a5,80005ee8 <consoleintr+0x3c>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80005f74:	863e                	mv	a2,a5
    80005f76:	a07d                	j	80006024 <consoleintr+0x178>
    while(cons.e != cons.w &&
    80005f78:	00024717          	auipc	a4,0x24
    80005f7c:	1f870713          	addi	a4,a4,504 # 8002a170 <cons>
    80005f80:	0a872783          	lw	a5,168(a4)
    80005f84:	0a472703          	lw	a4,164(a4)
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80005f88:	00024497          	auipc	s1,0x24
    80005f8c:	1e848493          	addi	s1,s1,488 # 8002a170 <cons>
    while(cons.e != cons.w &&
    80005f90:	4929                	li	s2,10
    80005f92:	f4f70be3          	beq	a4,a5,80005ee8 <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80005f96:	37fd                	addiw	a5,a5,-1
    80005f98:	07f7f713          	andi	a4,a5,127
    80005f9c:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    80005f9e:	02074703          	lbu	a4,32(a4)
    80005fa2:	f52703e3          	beq	a4,s2,80005ee8 <consoleintr+0x3c>
      cons.e--;
    80005fa6:	0af4a423          	sw	a5,168(s1)
      consputc(BACKSPACE);
    80005faa:	10000513          	li	a0,256
    80005fae:	00000097          	auipc	ra,0x0
    80005fb2:	ebc080e7          	jalr	-324(ra) # 80005e6a <consputc>
    while(cons.e != cons.w &&
    80005fb6:	0a84a783          	lw	a5,168(s1)
    80005fba:	0a44a703          	lw	a4,164(s1)
    80005fbe:	fcf71ce3          	bne	a4,a5,80005f96 <consoleintr+0xea>
    80005fc2:	b71d                	j	80005ee8 <consoleintr+0x3c>
    if(cons.e != cons.w){
    80005fc4:	00024717          	auipc	a4,0x24
    80005fc8:	1ac70713          	addi	a4,a4,428 # 8002a170 <cons>
    80005fcc:	0a872783          	lw	a5,168(a4)
    80005fd0:	0a472703          	lw	a4,164(a4)
    80005fd4:	f0f70ae3          	beq	a4,a5,80005ee8 <consoleintr+0x3c>
      cons.e--;
    80005fd8:	37fd                	addiw	a5,a5,-1
    80005fda:	00024717          	auipc	a4,0x24
    80005fde:	22f72f23          	sw	a5,574(a4) # 8002a218 <cons+0xa8>
      consputc(BACKSPACE);
    80005fe2:	10000513          	li	a0,256
    80005fe6:	00000097          	auipc	ra,0x0
    80005fea:	e84080e7          	jalr	-380(ra) # 80005e6a <consputc>
    80005fee:	bded                	j	80005ee8 <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80005ff0:	ee048ce3          	beqz	s1,80005ee8 <consoleintr+0x3c>
    80005ff4:	bf21                	j	80005f0c <consoleintr+0x60>
      consputc(c);
    80005ff6:	4529                	li	a0,10
    80005ff8:	00000097          	auipc	ra,0x0
    80005ffc:	e72080e7          	jalr	-398(ra) # 80005e6a <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80006000:	00024797          	auipc	a5,0x24
    80006004:	17078793          	addi	a5,a5,368 # 8002a170 <cons>
    80006008:	0a87a703          	lw	a4,168(a5)
    8000600c:	0017069b          	addiw	a3,a4,1
    80006010:	0006861b          	sext.w	a2,a3
    80006014:	0ad7a423          	sw	a3,168(a5)
    80006018:	07f77713          	andi	a4,a4,127
    8000601c:	97ba                	add	a5,a5,a4
    8000601e:	4729                	li	a4,10
    80006020:	02e78023          	sb	a4,32(a5)
        cons.w = cons.e;
    80006024:	00024797          	auipc	a5,0x24
    80006028:	1ec7a823          	sw	a2,496(a5) # 8002a214 <cons+0xa4>
        wakeup(&cons.r);
    8000602c:	00024517          	auipc	a0,0x24
    80006030:	1e450513          	addi	a0,a0,484 # 8002a210 <cons+0xa0>
    80006034:	ffffb097          	auipc	ra,0xffffb
    80006038:	74a080e7          	jalr	1866(ra) # 8000177e <wakeup>
    8000603c:	b575                	j	80005ee8 <consoleintr+0x3c>

000000008000603e <consoleinit>:

void
consoleinit(void)
{
    8000603e:	1141                	addi	sp,sp,-16
    80006040:	e406                	sd	ra,8(sp)
    80006042:	e022                	sd	s0,0(sp)
    80006044:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80006046:	00002597          	auipc	a1,0x2
    8000604a:	78258593          	addi	a1,a1,1922 # 800087c8 <digits+0x18>
    8000604e:	00024517          	auipc	a0,0x24
    80006052:	12250513          	addi	a0,a0,290 # 8002a170 <cons>
    80006056:	00000097          	auipc	ra,0x0
    8000605a:	786080e7          	jalr	1926(ra) # 800067dc <initlock>

  uartinit();
    8000605e:	00000097          	auipc	ra,0x0
    80006062:	330080e7          	jalr	816(ra) # 8000638e <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80006066:	00017797          	auipc	a5,0x17
    8000606a:	d9278793          	addi	a5,a5,-622 # 8001cdf8 <devsw>
    8000606e:	00000717          	auipc	a4,0x0
    80006072:	ce470713          	addi	a4,a4,-796 # 80005d52 <consoleread>
    80006076:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80006078:	00000717          	auipc	a4,0x0
    8000607c:	c7870713          	addi	a4,a4,-904 # 80005cf0 <consolewrite>
    80006080:	ef98                	sd	a4,24(a5)
}
    80006082:	60a2                	ld	ra,8(sp)
    80006084:	6402                	ld	s0,0(sp)
    80006086:	0141                	addi	sp,sp,16
    80006088:	8082                	ret

000000008000608a <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    8000608a:	7179                	addi	sp,sp,-48
    8000608c:	f406                	sd	ra,40(sp)
    8000608e:	f022                	sd	s0,32(sp)
    80006090:	ec26                	sd	s1,24(sp)
    80006092:	e84a                	sd	s2,16(sp)
    80006094:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    80006096:	c219                	beqz	a2,8000609c <printint+0x12>
    80006098:	08054663          	bltz	a0,80006124 <printint+0x9a>
    x = -xx;
  else
    x = xx;
    8000609c:	2501                	sext.w	a0,a0
    8000609e:	4881                	li	a7,0
    800060a0:	fd040693          	addi	a3,s0,-48

  i = 0;
    800060a4:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    800060a6:	2581                	sext.w	a1,a1
    800060a8:	00002617          	auipc	a2,0x2
    800060ac:	73860613          	addi	a2,a2,1848 # 800087e0 <digits>
    800060b0:	883a                	mv	a6,a4
    800060b2:	2705                	addiw	a4,a4,1
    800060b4:	02b577bb          	remuw	a5,a0,a1
    800060b8:	1782                	slli	a5,a5,0x20
    800060ba:	9381                	srli	a5,a5,0x20
    800060bc:	97b2                	add	a5,a5,a2
    800060be:	0007c783          	lbu	a5,0(a5)
    800060c2:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    800060c6:	0005079b          	sext.w	a5,a0
    800060ca:	02b5553b          	divuw	a0,a0,a1
    800060ce:	0685                	addi	a3,a3,1
    800060d0:	feb7f0e3          	bgeu	a5,a1,800060b0 <printint+0x26>

  if(sign)
    800060d4:	00088b63          	beqz	a7,800060ea <printint+0x60>
    buf[i++] = '-';
    800060d8:	fe040793          	addi	a5,s0,-32
    800060dc:	973e                	add	a4,a4,a5
    800060de:	02d00793          	li	a5,45
    800060e2:	fef70823          	sb	a5,-16(a4)
    800060e6:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    800060ea:	02e05763          	blez	a4,80006118 <printint+0x8e>
    800060ee:	fd040793          	addi	a5,s0,-48
    800060f2:	00e784b3          	add	s1,a5,a4
    800060f6:	fff78913          	addi	s2,a5,-1
    800060fa:	993a                	add	s2,s2,a4
    800060fc:	377d                	addiw	a4,a4,-1
    800060fe:	1702                	slli	a4,a4,0x20
    80006100:	9301                	srli	a4,a4,0x20
    80006102:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80006106:	fff4c503          	lbu	a0,-1(s1)
    8000610a:	00000097          	auipc	ra,0x0
    8000610e:	d60080e7          	jalr	-672(ra) # 80005e6a <consputc>
  while(--i >= 0)
    80006112:	14fd                	addi	s1,s1,-1
    80006114:	ff2499e3          	bne	s1,s2,80006106 <printint+0x7c>
}
    80006118:	70a2                	ld	ra,40(sp)
    8000611a:	7402                	ld	s0,32(sp)
    8000611c:	64e2                	ld	s1,24(sp)
    8000611e:	6942                	ld	s2,16(sp)
    80006120:	6145                	addi	sp,sp,48
    80006122:	8082                	ret
    x = -xx;
    80006124:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80006128:	4885                	li	a7,1
    x = -xx;
    8000612a:	bf9d                	j	800060a0 <printint+0x16>

000000008000612c <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    8000612c:	1101                	addi	sp,sp,-32
    8000612e:	ec06                	sd	ra,24(sp)
    80006130:	e822                	sd	s0,16(sp)
    80006132:	e426                	sd	s1,8(sp)
    80006134:	1000                	addi	s0,sp,32
    80006136:	84aa                	mv	s1,a0
  pr.locking = 0;
    80006138:	00024797          	auipc	a5,0x24
    8000613c:	1007a423          	sw	zero,264(a5) # 8002a240 <pr+0x20>
  printf("panic: ");
    80006140:	00002517          	auipc	a0,0x2
    80006144:	69050513          	addi	a0,a0,1680 # 800087d0 <digits+0x20>
    80006148:	00000097          	auipc	ra,0x0
    8000614c:	02e080e7          	jalr	46(ra) # 80006176 <printf>
  printf(s);
    80006150:	8526                	mv	a0,s1
    80006152:	00000097          	auipc	ra,0x0
    80006156:	024080e7          	jalr	36(ra) # 80006176 <printf>
  printf("\n");
    8000615a:	00002517          	auipc	a0,0x2
    8000615e:	70e50513          	addi	a0,a0,1806 # 80008868 <digits+0x88>
    80006162:	00000097          	auipc	ra,0x0
    80006166:	014080e7          	jalr	20(ra) # 80006176 <printf>
  panicked = 1; // freeze uart output from other CPUs
    8000616a:	4785                	li	a5,1
    8000616c:	00003717          	auipc	a4,0x3
    80006170:	eaf72823          	sw	a5,-336(a4) # 8000901c <panicked>
  for(;;)
    80006174:	a001                	j	80006174 <panic+0x48>

0000000080006176 <printf>:
{
    80006176:	7131                	addi	sp,sp,-192
    80006178:	fc86                	sd	ra,120(sp)
    8000617a:	f8a2                	sd	s0,112(sp)
    8000617c:	f4a6                	sd	s1,104(sp)
    8000617e:	f0ca                	sd	s2,96(sp)
    80006180:	ecce                	sd	s3,88(sp)
    80006182:	e8d2                	sd	s4,80(sp)
    80006184:	e4d6                	sd	s5,72(sp)
    80006186:	e0da                	sd	s6,64(sp)
    80006188:	fc5e                	sd	s7,56(sp)
    8000618a:	f862                	sd	s8,48(sp)
    8000618c:	f466                	sd	s9,40(sp)
    8000618e:	f06a                	sd	s10,32(sp)
    80006190:	ec6e                	sd	s11,24(sp)
    80006192:	0100                	addi	s0,sp,128
    80006194:	8a2a                	mv	s4,a0
    80006196:	e40c                	sd	a1,8(s0)
    80006198:	e810                	sd	a2,16(s0)
    8000619a:	ec14                	sd	a3,24(s0)
    8000619c:	f018                	sd	a4,32(s0)
    8000619e:	f41c                	sd	a5,40(s0)
    800061a0:	03043823          	sd	a6,48(s0)
    800061a4:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    800061a8:	00024d97          	auipc	s11,0x24
    800061ac:	098dad83          	lw	s11,152(s11) # 8002a240 <pr+0x20>
  if(locking)
    800061b0:	020d9b63          	bnez	s11,800061e6 <printf+0x70>
  if (fmt == 0)
    800061b4:	040a0263          	beqz	s4,800061f8 <printf+0x82>
  va_start(ap, fmt);
    800061b8:	00840793          	addi	a5,s0,8
    800061bc:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800061c0:	000a4503          	lbu	a0,0(s4)
    800061c4:	16050263          	beqz	a0,80006328 <printf+0x1b2>
    800061c8:	4481                	li	s1,0
    if(c != '%'){
    800061ca:	02500a93          	li	s5,37
    switch(c){
    800061ce:	07000b13          	li	s6,112
  consputc('x');
    800061d2:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800061d4:	00002b97          	auipc	s7,0x2
    800061d8:	60cb8b93          	addi	s7,s7,1548 # 800087e0 <digits>
    switch(c){
    800061dc:	07300c93          	li	s9,115
    800061e0:	06400c13          	li	s8,100
    800061e4:	a82d                	j	8000621e <printf+0xa8>
    acquire(&pr.lock);
    800061e6:	00024517          	auipc	a0,0x24
    800061ea:	03a50513          	addi	a0,a0,58 # 8002a220 <pr>
    800061ee:	00000097          	auipc	ra,0x0
    800061f2:	472080e7          	jalr	1138(ra) # 80006660 <acquire>
    800061f6:	bf7d                	j	800061b4 <printf+0x3e>
    panic("null fmt");
    800061f8:	00002517          	auipc	a0,0x2
    800061fc:	5a850513          	addi	a0,a0,1448 # 800087a0 <syscalls+0x3d8>
    80006200:	00000097          	auipc	ra,0x0
    80006204:	f2c080e7          	jalr	-212(ra) # 8000612c <panic>
      consputc(c);
    80006208:	00000097          	auipc	ra,0x0
    8000620c:	c62080e7          	jalr	-926(ra) # 80005e6a <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80006210:	2485                	addiw	s1,s1,1
    80006212:	009a07b3          	add	a5,s4,s1
    80006216:	0007c503          	lbu	a0,0(a5)
    8000621a:	10050763          	beqz	a0,80006328 <printf+0x1b2>
    if(c != '%'){
    8000621e:	ff5515e3          	bne	a0,s5,80006208 <printf+0x92>
    c = fmt[++i] & 0xff;
    80006222:	2485                	addiw	s1,s1,1
    80006224:	009a07b3          	add	a5,s4,s1
    80006228:	0007c783          	lbu	a5,0(a5)
    8000622c:	0007891b          	sext.w	s2,a5
    if(c == 0)
    80006230:	cfe5                	beqz	a5,80006328 <printf+0x1b2>
    switch(c){
    80006232:	05678a63          	beq	a5,s6,80006286 <printf+0x110>
    80006236:	02fb7663          	bgeu	s6,a5,80006262 <printf+0xec>
    8000623a:	09978963          	beq	a5,s9,800062cc <printf+0x156>
    8000623e:	07800713          	li	a4,120
    80006242:	0ce79863          	bne	a5,a4,80006312 <printf+0x19c>
      printint(va_arg(ap, int), 16, 1);
    80006246:	f8843783          	ld	a5,-120(s0)
    8000624a:	00878713          	addi	a4,a5,8
    8000624e:	f8e43423          	sd	a4,-120(s0)
    80006252:	4605                	li	a2,1
    80006254:	85ea                	mv	a1,s10
    80006256:	4388                	lw	a0,0(a5)
    80006258:	00000097          	auipc	ra,0x0
    8000625c:	e32080e7          	jalr	-462(ra) # 8000608a <printint>
      break;
    80006260:	bf45                	j	80006210 <printf+0x9a>
    switch(c){
    80006262:	0b578263          	beq	a5,s5,80006306 <printf+0x190>
    80006266:	0b879663          	bne	a5,s8,80006312 <printf+0x19c>
      printint(va_arg(ap, int), 10, 1);
    8000626a:	f8843783          	ld	a5,-120(s0)
    8000626e:	00878713          	addi	a4,a5,8
    80006272:	f8e43423          	sd	a4,-120(s0)
    80006276:	4605                	li	a2,1
    80006278:	45a9                	li	a1,10
    8000627a:	4388                	lw	a0,0(a5)
    8000627c:	00000097          	auipc	ra,0x0
    80006280:	e0e080e7          	jalr	-498(ra) # 8000608a <printint>
      break;
    80006284:	b771                	j	80006210 <printf+0x9a>
      printptr(va_arg(ap, uint64));
    80006286:	f8843783          	ld	a5,-120(s0)
    8000628a:	00878713          	addi	a4,a5,8
    8000628e:	f8e43423          	sd	a4,-120(s0)
    80006292:	0007b983          	ld	s3,0(a5)
  consputc('0');
    80006296:	03000513          	li	a0,48
    8000629a:	00000097          	auipc	ra,0x0
    8000629e:	bd0080e7          	jalr	-1072(ra) # 80005e6a <consputc>
  consputc('x');
    800062a2:	07800513          	li	a0,120
    800062a6:	00000097          	auipc	ra,0x0
    800062aa:	bc4080e7          	jalr	-1084(ra) # 80005e6a <consputc>
    800062ae:	896a                	mv	s2,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800062b0:	03c9d793          	srli	a5,s3,0x3c
    800062b4:	97de                	add	a5,a5,s7
    800062b6:	0007c503          	lbu	a0,0(a5)
    800062ba:	00000097          	auipc	ra,0x0
    800062be:	bb0080e7          	jalr	-1104(ra) # 80005e6a <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800062c2:	0992                	slli	s3,s3,0x4
    800062c4:	397d                	addiw	s2,s2,-1
    800062c6:	fe0915e3          	bnez	s2,800062b0 <printf+0x13a>
    800062ca:	b799                	j	80006210 <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    800062cc:	f8843783          	ld	a5,-120(s0)
    800062d0:	00878713          	addi	a4,a5,8
    800062d4:	f8e43423          	sd	a4,-120(s0)
    800062d8:	0007b903          	ld	s2,0(a5)
    800062dc:	00090e63          	beqz	s2,800062f8 <printf+0x182>
      for(; *s; s++)
    800062e0:	00094503          	lbu	a0,0(s2)
    800062e4:	d515                	beqz	a0,80006210 <printf+0x9a>
        consputc(*s);
    800062e6:	00000097          	auipc	ra,0x0
    800062ea:	b84080e7          	jalr	-1148(ra) # 80005e6a <consputc>
      for(; *s; s++)
    800062ee:	0905                	addi	s2,s2,1
    800062f0:	00094503          	lbu	a0,0(s2)
    800062f4:	f96d                	bnez	a0,800062e6 <printf+0x170>
    800062f6:	bf29                	j	80006210 <printf+0x9a>
        s = "(null)";
    800062f8:	00002917          	auipc	s2,0x2
    800062fc:	4a090913          	addi	s2,s2,1184 # 80008798 <syscalls+0x3d0>
      for(; *s; s++)
    80006300:	02800513          	li	a0,40
    80006304:	b7cd                	j	800062e6 <printf+0x170>
      consputc('%');
    80006306:	8556                	mv	a0,s5
    80006308:	00000097          	auipc	ra,0x0
    8000630c:	b62080e7          	jalr	-1182(ra) # 80005e6a <consputc>
      break;
    80006310:	b701                	j	80006210 <printf+0x9a>
      consputc('%');
    80006312:	8556                	mv	a0,s5
    80006314:	00000097          	auipc	ra,0x0
    80006318:	b56080e7          	jalr	-1194(ra) # 80005e6a <consputc>
      consputc(c);
    8000631c:	854a                	mv	a0,s2
    8000631e:	00000097          	auipc	ra,0x0
    80006322:	b4c080e7          	jalr	-1204(ra) # 80005e6a <consputc>
      break;
    80006326:	b5ed                	j	80006210 <printf+0x9a>
  if(locking)
    80006328:	020d9163          	bnez	s11,8000634a <printf+0x1d4>
}
    8000632c:	70e6                	ld	ra,120(sp)
    8000632e:	7446                	ld	s0,112(sp)
    80006330:	74a6                	ld	s1,104(sp)
    80006332:	7906                	ld	s2,96(sp)
    80006334:	69e6                	ld	s3,88(sp)
    80006336:	6a46                	ld	s4,80(sp)
    80006338:	6aa6                	ld	s5,72(sp)
    8000633a:	6b06                	ld	s6,64(sp)
    8000633c:	7be2                	ld	s7,56(sp)
    8000633e:	7c42                	ld	s8,48(sp)
    80006340:	7ca2                	ld	s9,40(sp)
    80006342:	7d02                	ld	s10,32(sp)
    80006344:	6de2                	ld	s11,24(sp)
    80006346:	6129                	addi	sp,sp,192
    80006348:	8082                	ret
    release(&pr.lock);
    8000634a:	00024517          	auipc	a0,0x24
    8000634e:	ed650513          	addi	a0,a0,-298 # 8002a220 <pr>
    80006352:	00000097          	auipc	ra,0x0
    80006356:	3de080e7          	jalr	990(ra) # 80006730 <release>
}
    8000635a:	bfc9                	j	8000632c <printf+0x1b6>

000000008000635c <printfinit>:
    ;
}

void
printfinit(void)
{
    8000635c:	1101                	addi	sp,sp,-32
    8000635e:	ec06                	sd	ra,24(sp)
    80006360:	e822                	sd	s0,16(sp)
    80006362:	e426                	sd	s1,8(sp)
    80006364:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    80006366:	00024497          	auipc	s1,0x24
    8000636a:	eba48493          	addi	s1,s1,-326 # 8002a220 <pr>
    8000636e:	00002597          	auipc	a1,0x2
    80006372:	46a58593          	addi	a1,a1,1130 # 800087d8 <digits+0x28>
    80006376:	8526                	mv	a0,s1
    80006378:	00000097          	auipc	ra,0x0
    8000637c:	464080e7          	jalr	1124(ra) # 800067dc <initlock>
  pr.locking = 1;
    80006380:	4785                	li	a5,1
    80006382:	d09c                	sw	a5,32(s1)
}
    80006384:	60e2                	ld	ra,24(sp)
    80006386:	6442                	ld	s0,16(sp)
    80006388:	64a2                	ld	s1,8(sp)
    8000638a:	6105                	addi	sp,sp,32
    8000638c:	8082                	ret

000000008000638e <uartinit>:

void uartstart();

void
uartinit(void)
{
    8000638e:	1141                	addi	sp,sp,-16
    80006390:	e406                	sd	ra,8(sp)
    80006392:	e022                	sd	s0,0(sp)
    80006394:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80006396:	100007b7          	lui	a5,0x10000
    8000639a:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    8000639e:	f8000713          	li	a4,-128
    800063a2:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    800063a6:	470d                	li	a4,3
    800063a8:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    800063ac:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    800063b0:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    800063b4:	469d                	li	a3,7
    800063b6:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800063ba:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    800063be:	00002597          	auipc	a1,0x2
    800063c2:	43a58593          	addi	a1,a1,1082 # 800087f8 <digits+0x18>
    800063c6:	00024517          	auipc	a0,0x24
    800063ca:	e8250513          	addi	a0,a0,-382 # 8002a248 <uart_tx_lock>
    800063ce:	00000097          	auipc	ra,0x0
    800063d2:	40e080e7          	jalr	1038(ra) # 800067dc <initlock>
}
    800063d6:	60a2                	ld	ra,8(sp)
    800063d8:	6402                	ld	s0,0(sp)
    800063da:	0141                	addi	sp,sp,16
    800063dc:	8082                	ret

00000000800063de <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    800063de:	1101                	addi	sp,sp,-32
    800063e0:	ec06                	sd	ra,24(sp)
    800063e2:	e822                	sd	s0,16(sp)
    800063e4:	e426                	sd	s1,8(sp)
    800063e6:	1000                	addi	s0,sp,32
    800063e8:	84aa                	mv	s1,a0
  push_off();
    800063ea:	00000097          	auipc	ra,0x0
    800063ee:	22a080e7          	jalr	554(ra) # 80006614 <push_off>

  if(panicked){
    800063f2:	00003797          	auipc	a5,0x3
    800063f6:	c2a7a783          	lw	a5,-982(a5) # 8000901c <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800063fa:	10000737          	lui	a4,0x10000
  if(panicked){
    800063fe:	c391                	beqz	a5,80006402 <uartputc_sync+0x24>
    for(;;)
    80006400:	a001                	j	80006400 <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80006402:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80006406:	0ff7f793          	andi	a5,a5,255
    8000640a:	0207f793          	andi	a5,a5,32
    8000640e:	dbf5                	beqz	a5,80006402 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80006410:	0ff4f793          	andi	a5,s1,255
    80006414:	10000737          	lui	a4,0x10000
    80006418:	00f70023          	sb	a5,0(a4) # 10000000 <_entry-0x70000000>

  pop_off();
    8000641c:	00000097          	auipc	ra,0x0
    80006420:	2b4080e7          	jalr	692(ra) # 800066d0 <pop_off>
}
    80006424:	60e2                	ld	ra,24(sp)
    80006426:	6442                	ld	s0,16(sp)
    80006428:	64a2                	ld	s1,8(sp)
    8000642a:	6105                	addi	sp,sp,32
    8000642c:	8082                	ret

000000008000642e <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    8000642e:	00003717          	auipc	a4,0x3
    80006432:	bf273703          	ld	a4,-1038(a4) # 80009020 <uart_tx_r>
    80006436:	00003797          	auipc	a5,0x3
    8000643a:	bf27b783          	ld	a5,-1038(a5) # 80009028 <uart_tx_w>
    8000643e:	06e78c63          	beq	a5,a4,800064b6 <uartstart+0x88>
{
    80006442:	7139                	addi	sp,sp,-64
    80006444:	fc06                	sd	ra,56(sp)
    80006446:	f822                	sd	s0,48(sp)
    80006448:	f426                	sd	s1,40(sp)
    8000644a:	f04a                	sd	s2,32(sp)
    8000644c:	ec4e                	sd	s3,24(sp)
    8000644e:	e852                	sd	s4,16(sp)
    80006450:	e456                	sd	s5,8(sp)
    80006452:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80006454:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80006458:	00024a17          	auipc	s4,0x24
    8000645c:	df0a0a13          	addi	s4,s4,-528 # 8002a248 <uart_tx_lock>
    uart_tx_r += 1;
    80006460:	00003497          	auipc	s1,0x3
    80006464:	bc048493          	addi	s1,s1,-1088 # 80009020 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    80006468:	00003997          	auipc	s3,0x3
    8000646c:	bc098993          	addi	s3,s3,-1088 # 80009028 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80006470:	00594783          	lbu	a5,5(s2) # 10000005 <_entry-0x6ffffffb>
    80006474:	0ff7f793          	andi	a5,a5,255
    80006478:	0207f793          	andi	a5,a5,32
    8000647c:	c785                	beqz	a5,800064a4 <uartstart+0x76>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000647e:	01f77793          	andi	a5,a4,31
    80006482:	97d2                	add	a5,a5,s4
    80006484:	0207ca83          	lbu	s5,32(a5)
    uart_tx_r += 1;
    80006488:	0705                	addi	a4,a4,1
    8000648a:	e098                	sd	a4,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    8000648c:	8526                	mv	a0,s1
    8000648e:	ffffb097          	auipc	ra,0xffffb
    80006492:	2f0080e7          	jalr	752(ra) # 8000177e <wakeup>
    
    WriteReg(THR, c);
    80006496:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    8000649a:	6098                	ld	a4,0(s1)
    8000649c:	0009b783          	ld	a5,0(s3)
    800064a0:	fce798e3          	bne	a5,a4,80006470 <uartstart+0x42>
  }
}
    800064a4:	70e2                	ld	ra,56(sp)
    800064a6:	7442                	ld	s0,48(sp)
    800064a8:	74a2                	ld	s1,40(sp)
    800064aa:	7902                	ld	s2,32(sp)
    800064ac:	69e2                	ld	s3,24(sp)
    800064ae:	6a42                	ld	s4,16(sp)
    800064b0:	6aa2                	ld	s5,8(sp)
    800064b2:	6121                	addi	sp,sp,64
    800064b4:	8082                	ret
    800064b6:	8082                	ret

00000000800064b8 <uartputc>:
{
    800064b8:	7179                	addi	sp,sp,-48
    800064ba:	f406                	sd	ra,40(sp)
    800064bc:	f022                	sd	s0,32(sp)
    800064be:	ec26                	sd	s1,24(sp)
    800064c0:	e84a                	sd	s2,16(sp)
    800064c2:	e44e                	sd	s3,8(sp)
    800064c4:	e052                	sd	s4,0(sp)
    800064c6:	1800                	addi	s0,sp,48
    800064c8:	89aa                	mv	s3,a0
  acquire(&uart_tx_lock);
    800064ca:	00024517          	auipc	a0,0x24
    800064ce:	d7e50513          	addi	a0,a0,-642 # 8002a248 <uart_tx_lock>
    800064d2:	00000097          	auipc	ra,0x0
    800064d6:	18e080e7          	jalr	398(ra) # 80006660 <acquire>
  if(panicked){
    800064da:	00003797          	auipc	a5,0x3
    800064de:	b427a783          	lw	a5,-1214(a5) # 8000901c <panicked>
    800064e2:	c391                	beqz	a5,800064e6 <uartputc+0x2e>
    for(;;)
    800064e4:	a001                	j	800064e4 <uartputc+0x2c>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800064e6:	00003797          	auipc	a5,0x3
    800064ea:	b427b783          	ld	a5,-1214(a5) # 80009028 <uart_tx_w>
    800064ee:	00003717          	auipc	a4,0x3
    800064f2:	b3273703          	ld	a4,-1230(a4) # 80009020 <uart_tx_r>
    800064f6:	02070713          	addi	a4,a4,32
    800064fa:	02f71b63          	bne	a4,a5,80006530 <uartputc+0x78>
      sleep(&uart_tx_r, &uart_tx_lock);
    800064fe:	00024a17          	auipc	s4,0x24
    80006502:	d4aa0a13          	addi	s4,s4,-694 # 8002a248 <uart_tx_lock>
    80006506:	00003497          	auipc	s1,0x3
    8000650a:	b1a48493          	addi	s1,s1,-1254 # 80009020 <uart_tx_r>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000650e:	00003917          	auipc	s2,0x3
    80006512:	b1a90913          	addi	s2,s2,-1254 # 80009028 <uart_tx_w>
      sleep(&uart_tx_r, &uart_tx_lock);
    80006516:	85d2                	mv	a1,s4
    80006518:	8526                	mv	a0,s1
    8000651a:	ffffb097          	auipc	ra,0xffffb
    8000651e:	0d8080e7          	jalr	216(ra) # 800015f2 <sleep>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80006522:	00093783          	ld	a5,0(s2)
    80006526:	6098                	ld	a4,0(s1)
    80006528:	02070713          	addi	a4,a4,32
    8000652c:	fef705e3          	beq	a4,a5,80006516 <uartputc+0x5e>
      uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80006530:	00024497          	auipc	s1,0x24
    80006534:	d1848493          	addi	s1,s1,-744 # 8002a248 <uart_tx_lock>
    80006538:	01f7f713          	andi	a4,a5,31
    8000653c:	9726                	add	a4,a4,s1
    8000653e:	03370023          	sb	s3,32(a4)
      uart_tx_w += 1;
    80006542:	0785                	addi	a5,a5,1
    80006544:	00003717          	auipc	a4,0x3
    80006548:	aef73223          	sd	a5,-1308(a4) # 80009028 <uart_tx_w>
      uartstart();
    8000654c:	00000097          	auipc	ra,0x0
    80006550:	ee2080e7          	jalr	-286(ra) # 8000642e <uartstart>
      release(&uart_tx_lock);
    80006554:	8526                	mv	a0,s1
    80006556:	00000097          	auipc	ra,0x0
    8000655a:	1da080e7          	jalr	474(ra) # 80006730 <release>
}
    8000655e:	70a2                	ld	ra,40(sp)
    80006560:	7402                	ld	s0,32(sp)
    80006562:	64e2                	ld	s1,24(sp)
    80006564:	6942                	ld	s2,16(sp)
    80006566:	69a2                	ld	s3,8(sp)
    80006568:	6a02                	ld	s4,0(sp)
    8000656a:	6145                	addi	sp,sp,48
    8000656c:	8082                	ret

000000008000656e <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    8000656e:	1141                	addi	sp,sp,-16
    80006570:	e422                	sd	s0,8(sp)
    80006572:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80006574:	100007b7          	lui	a5,0x10000
    80006578:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    8000657c:	8b85                	andi	a5,a5,1
    8000657e:	cb91                	beqz	a5,80006592 <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    80006580:	100007b7          	lui	a5,0x10000
    80006584:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
    80006588:	0ff57513          	andi	a0,a0,255
  } else {
    return -1;
  }
}
    8000658c:	6422                	ld	s0,8(sp)
    8000658e:	0141                	addi	sp,sp,16
    80006590:	8082                	ret
    return -1;
    80006592:	557d                	li	a0,-1
    80006594:	bfe5                	j	8000658c <uartgetc+0x1e>

0000000080006596 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void
uartintr(void)
{
    80006596:	1101                	addi	sp,sp,-32
    80006598:	ec06                	sd	ra,24(sp)
    8000659a:	e822                	sd	s0,16(sp)
    8000659c:	e426                	sd	s1,8(sp)
    8000659e:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    800065a0:	54fd                	li	s1,-1
    int c = uartgetc();
    800065a2:	00000097          	auipc	ra,0x0
    800065a6:	fcc080e7          	jalr	-52(ra) # 8000656e <uartgetc>
    if(c == -1)
    800065aa:	00950763          	beq	a0,s1,800065b8 <uartintr+0x22>
      break;
    consoleintr(c);
    800065ae:	00000097          	auipc	ra,0x0
    800065b2:	8fe080e7          	jalr	-1794(ra) # 80005eac <consoleintr>
  while(1){
    800065b6:	b7f5                	j	800065a2 <uartintr+0xc>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    800065b8:	00024497          	auipc	s1,0x24
    800065bc:	c9048493          	addi	s1,s1,-880 # 8002a248 <uart_tx_lock>
    800065c0:	8526                	mv	a0,s1
    800065c2:	00000097          	auipc	ra,0x0
    800065c6:	09e080e7          	jalr	158(ra) # 80006660 <acquire>
  uartstart();
    800065ca:	00000097          	auipc	ra,0x0
    800065ce:	e64080e7          	jalr	-412(ra) # 8000642e <uartstart>
  release(&uart_tx_lock);
    800065d2:	8526                	mv	a0,s1
    800065d4:	00000097          	auipc	ra,0x0
    800065d8:	15c080e7          	jalr	348(ra) # 80006730 <release>
}
    800065dc:	60e2                	ld	ra,24(sp)
    800065de:	6442                	ld	s0,16(sp)
    800065e0:	64a2                	ld	s1,8(sp)
    800065e2:	6105                	addi	sp,sp,32
    800065e4:	8082                	ret

00000000800065e6 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    800065e6:	411c                	lw	a5,0(a0)
    800065e8:	e399                	bnez	a5,800065ee <holding+0x8>
    800065ea:	4501                	li	a0,0
  return r;
}
    800065ec:	8082                	ret
{
    800065ee:	1101                	addi	sp,sp,-32
    800065f0:	ec06                	sd	ra,24(sp)
    800065f2:	e822                	sd	s0,16(sp)
    800065f4:	e426                	sd	s1,8(sp)
    800065f6:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    800065f8:	6904                	ld	s1,16(a0)
    800065fa:	ffffb097          	auipc	ra,0xffffb
    800065fe:	920080e7          	jalr	-1760(ra) # 80000f1a <mycpu>
    80006602:	40a48533          	sub	a0,s1,a0
    80006606:	00153513          	seqz	a0,a0
}
    8000660a:	60e2                	ld	ra,24(sp)
    8000660c:	6442                	ld	s0,16(sp)
    8000660e:	64a2                	ld	s1,8(sp)
    80006610:	6105                	addi	sp,sp,32
    80006612:	8082                	ret

0000000080006614 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80006614:	1101                	addi	sp,sp,-32
    80006616:	ec06                	sd	ra,24(sp)
    80006618:	e822                	sd	s0,16(sp)
    8000661a:	e426                	sd	s1,8(sp)
    8000661c:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000661e:	100024f3          	csrr	s1,sstatus
    80006622:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80006626:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80006628:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    8000662c:	ffffb097          	auipc	ra,0xffffb
    80006630:	8ee080e7          	jalr	-1810(ra) # 80000f1a <mycpu>
    80006634:	5d3c                	lw	a5,120(a0)
    80006636:	cf89                	beqz	a5,80006650 <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80006638:	ffffb097          	auipc	ra,0xffffb
    8000663c:	8e2080e7          	jalr	-1822(ra) # 80000f1a <mycpu>
    80006640:	5d3c                	lw	a5,120(a0)
    80006642:	2785                	addiw	a5,a5,1
    80006644:	dd3c                	sw	a5,120(a0)
}
    80006646:	60e2                	ld	ra,24(sp)
    80006648:	6442                	ld	s0,16(sp)
    8000664a:	64a2                	ld	s1,8(sp)
    8000664c:	6105                	addi	sp,sp,32
    8000664e:	8082                	ret
    mycpu()->intena = old;
    80006650:	ffffb097          	auipc	ra,0xffffb
    80006654:	8ca080e7          	jalr	-1846(ra) # 80000f1a <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80006658:	8085                	srli	s1,s1,0x1
    8000665a:	8885                	andi	s1,s1,1
    8000665c:	dd64                	sw	s1,124(a0)
    8000665e:	bfe9                	j	80006638 <push_off+0x24>

0000000080006660 <acquire>:
{
    80006660:	1101                	addi	sp,sp,-32
    80006662:	ec06                	sd	ra,24(sp)
    80006664:	e822                	sd	s0,16(sp)
    80006666:	e426                	sd	s1,8(sp)
    80006668:	1000                	addi	s0,sp,32
    8000666a:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    8000666c:	00000097          	auipc	ra,0x0
    80006670:	fa8080e7          	jalr	-88(ra) # 80006614 <push_off>
  if(holding(lk))
    80006674:	8526                	mv	a0,s1
    80006676:	00000097          	auipc	ra,0x0
    8000667a:	f70080e7          	jalr	-144(ra) # 800065e6 <holding>
    8000667e:	e911                	bnez	a0,80006692 <acquire+0x32>
    __sync_fetch_and_add(&(lk->n), 1);
    80006680:	4785                	li	a5,1
    80006682:	01c48713          	addi	a4,s1,28
    80006686:	0f50000f          	fence	iorw,ow
    8000668a:	04f7202f          	amoadd.w.aq	zero,a5,(a4)
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) {
    8000668e:	4705                	li	a4,1
    80006690:	a839                	j	800066ae <acquire+0x4e>
    panic("acquire");
    80006692:	00002517          	auipc	a0,0x2
    80006696:	16e50513          	addi	a0,a0,366 # 80008800 <digits+0x20>
    8000669a:	00000097          	auipc	ra,0x0
    8000669e:	a92080e7          	jalr	-1390(ra) # 8000612c <panic>
    __sync_fetch_and_add(&(lk->nts), 1);
    800066a2:	01848793          	addi	a5,s1,24
    800066a6:	0f50000f          	fence	iorw,ow
    800066aa:	04e7a02f          	amoadd.w.aq	zero,a4,(a5)
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) {
    800066ae:	87ba                	mv	a5,a4
    800066b0:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800066b4:	2781                	sext.w	a5,a5
    800066b6:	f7f5                	bnez	a5,800066a2 <acquire+0x42>
  __sync_synchronize();
    800066b8:	0ff0000f          	fence
  lk->cpu = mycpu();
    800066bc:	ffffb097          	auipc	ra,0xffffb
    800066c0:	85e080e7          	jalr	-1954(ra) # 80000f1a <mycpu>
    800066c4:	e888                	sd	a0,16(s1)
}
    800066c6:	60e2                	ld	ra,24(sp)
    800066c8:	6442                	ld	s0,16(sp)
    800066ca:	64a2                	ld	s1,8(sp)
    800066cc:	6105                	addi	sp,sp,32
    800066ce:	8082                	ret

00000000800066d0 <pop_off>:

void
pop_off(void)
{
    800066d0:	1141                	addi	sp,sp,-16
    800066d2:	e406                	sd	ra,8(sp)
    800066d4:	e022                	sd	s0,0(sp)
    800066d6:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    800066d8:	ffffb097          	auipc	ra,0xffffb
    800066dc:	842080e7          	jalr	-1982(ra) # 80000f1a <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800066e0:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800066e4:	8b89                	andi	a5,a5,2
  if(intr_get())
    800066e6:	e78d                	bnez	a5,80006710 <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    800066e8:	5d3c                	lw	a5,120(a0)
    800066ea:	02f05b63          	blez	a5,80006720 <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    800066ee:	37fd                	addiw	a5,a5,-1
    800066f0:	0007871b          	sext.w	a4,a5
    800066f4:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    800066f6:	eb09                	bnez	a4,80006708 <pop_off+0x38>
    800066f8:	5d7c                	lw	a5,124(a0)
    800066fa:	c799                	beqz	a5,80006708 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800066fc:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80006700:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80006704:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80006708:	60a2                	ld	ra,8(sp)
    8000670a:	6402                	ld	s0,0(sp)
    8000670c:	0141                	addi	sp,sp,16
    8000670e:	8082                	ret
    panic("pop_off - interruptible");
    80006710:	00002517          	auipc	a0,0x2
    80006714:	0f850513          	addi	a0,a0,248 # 80008808 <digits+0x28>
    80006718:	00000097          	auipc	ra,0x0
    8000671c:	a14080e7          	jalr	-1516(ra) # 8000612c <panic>
    panic("pop_off");
    80006720:	00002517          	auipc	a0,0x2
    80006724:	10050513          	addi	a0,a0,256 # 80008820 <digits+0x40>
    80006728:	00000097          	auipc	ra,0x0
    8000672c:	a04080e7          	jalr	-1532(ra) # 8000612c <panic>

0000000080006730 <release>:
{
    80006730:	1101                	addi	sp,sp,-32
    80006732:	ec06                	sd	ra,24(sp)
    80006734:	e822                	sd	s0,16(sp)
    80006736:	e426                	sd	s1,8(sp)
    80006738:	1000                	addi	s0,sp,32
    8000673a:	84aa                	mv	s1,a0
  if(!holding(lk))
    8000673c:	00000097          	auipc	ra,0x0
    80006740:	eaa080e7          	jalr	-342(ra) # 800065e6 <holding>
    80006744:	c115                	beqz	a0,80006768 <release+0x38>
  lk->cpu = 0;
    80006746:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    8000674a:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    8000674e:	0f50000f          	fence	iorw,ow
    80006752:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    80006756:	00000097          	auipc	ra,0x0
    8000675a:	f7a080e7          	jalr	-134(ra) # 800066d0 <pop_off>
}
    8000675e:	60e2                	ld	ra,24(sp)
    80006760:	6442                	ld	s0,16(sp)
    80006762:	64a2                	ld	s1,8(sp)
    80006764:	6105                	addi	sp,sp,32
    80006766:	8082                	ret
    panic("release");
    80006768:	00002517          	auipc	a0,0x2
    8000676c:	0c050513          	addi	a0,a0,192 # 80008828 <digits+0x48>
    80006770:	00000097          	auipc	ra,0x0
    80006774:	9bc080e7          	jalr	-1604(ra) # 8000612c <panic>

0000000080006778 <freelock>:
{
    80006778:	1101                	addi	sp,sp,-32
    8000677a:	ec06                	sd	ra,24(sp)
    8000677c:	e822                	sd	s0,16(sp)
    8000677e:	e426                	sd	s1,8(sp)
    80006780:	1000                	addi	s0,sp,32
    80006782:	84aa                	mv	s1,a0
  acquire(&lock_locks);
    80006784:	00024517          	auipc	a0,0x24
    80006788:	b0450513          	addi	a0,a0,-1276 # 8002a288 <lock_locks>
    8000678c:	00000097          	auipc	ra,0x0
    80006790:	ed4080e7          	jalr	-300(ra) # 80006660 <acquire>
  for (i = 0; i < NLOCK; i++) {
    80006794:	00024717          	auipc	a4,0x24
    80006798:	b1470713          	addi	a4,a4,-1260 # 8002a2a8 <locks>
    8000679c:	4781                	li	a5,0
    8000679e:	1f400613          	li	a2,500
    if(locks[i] == lk) {
    800067a2:	6314                	ld	a3,0(a4)
    800067a4:	00968763          	beq	a3,s1,800067b2 <freelock+0x3a>
  for (i = 0; i < NLOCK; i++) {
    800067a8:	2785                	addiw	a5,a5,1
    800067aa:	0721                	addi	a4,a4,8
    800067ac:	fec79be3          	bne	a5,a2,800067a2 <freelock+0x2a>
    800067b0:	a809                	j	800067c2 <freelock+0x4a>
      locks[i] = 0;
    800067b2:	078e                	slli	a5,a5,0x3
    800067b4:	00024717          	auipc	a4,0x24
    800067b8:	af470713          	addi	a4,a4,-1292 # 8002a2a8 <locks>
    800067bc:	97ba                	add	a5,a5,a4
    800067be:	0007b023          	sd	zero,0(a5)
  release(&lock_locks);
    800067c2:	00024517          	auipc	a0,0x24
    800067c6:	ac650513          	addi	a0,a0,-1338 # 8002a288 <lock_locks>
    800067ca:	00000097          	auipc	ra,0x0
    800067ce:	f66080e7          	jalr	-154(ra) # 80006730 <release>
}
    800067d2:	60e2                	ld	ra,24(sp)
    800067d4:	6442                	ld	s0,16(sp)
    800067d6:	64a2                	ld	s1,8(sp)
    800067d8:	6105                	addi	sp,sp,32
    800067da:	8082                	ret

00000000800067dc <initlock>:
{
    800067dc:	1101                	addi	sp,sp,-32
    800067de:	ec06                	sd	ra,24(sp)
    800067e0:	e822                	sd	s0,16(sp)
    800067e2:	e426                	sd	s1,8(sp)
    800067e4:	1000                	addi	s0,sp,32
    800067e6:	84aa                	mv	s1,a0
  lk->name = name;
    800067e8:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    800067ea:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    800067ee:	00053823          	sd	zero,16(a0)
  lk->nts = 0;
    800067f2:	00052c23          	sw	zero,24(a0)
  lk->n = 0;
    800067f6:	00052e23          	sw	zero,28(a0)
  acquire(&lock_locks);
    800067fa:	00024517          	auipc	a0,0x24
    800067fe:	a8e50513          	addi	a0,a0,-1394 # 8002a288 <lock_locks>
    80006802:	00000097          	auipc	ra,0x0
    80006806:	e5e080e7          	jalr	-418(ra) # 80006660 <acquire>
  for (i = 0; i < NLOCK; i++) {
    8000680a:	00024717          	auipc	a4,0x24
    8000680e:	a9e70713          	addi	a4,a4,-1378 # 8002a2a8 <locks>
    80006812:	4781                	li	a5,0
    80006814:	1f400693          	li	a3,500
    if(locks[i] == 0) {
    80006818:	6310                	ld	a2,0(a4)
    8000681a:	ce09                	beqz	a2,80006834 <initlock+0x58>
  for (i = 0; i < NLOCK; i++) {
    8000681c:	2785                	addiw	a5,a5,1
    8000681e:	0721                	addi	a4,a4,8
    80006820:	fed79ce3          	bne	a5,a3,80006818 <initlock+0x3c>
  panic("findslot");
    80006824:	00002517          	auipc	a0,0x2
    80006828:	00c50513          	addi	a0,a0,12 # 80008830 <digits+0x50>
    8000682c:	00000097          	auipc	ra,0x0
    80006830:	900080e7          	jalr	-1792(ra) # 8000612c <panic>
      locks[i] = lk;
    80006834:	078e                	slli	a5,a5,0x3
    80006836:	00024717          	auipc	a4,0x24
    8000683a:	a7270713          	addi	a4,a4,-1422 # 8002a2a8 <locks>
    8000683e:	97ba                	add	a5,a5,a4
    80006840:	e384                	sd	s1,0(a5)
      release(&lock_locks);
    80006842:	00024517          	auipc	a0,0x24
    80006846:	a4650513          	addi	a0,a0,-1466 # 8002a288 <lock_locks>
    8000684a:	00000097          	auipc	ra,0x0
    8000684e:	ee6080e7          	jalr	-282(ra) # 80006730 <release>
}
    80006852:	60e2                	ld	ra,24(sp)
    80006854:	6442                	ld	s0,16(sp)
    80006856:	64a2                	ld	s1,8(sp)
    80006858:	6105                	addi	sp,sp,32
    8000685a:	8082                	ret

000000008000685c <lockfree_read8>:

// Read a shared 64-bit value without holding a lock
uint64
lockfree_read8(uint64 *addr) {
    8000685c:	1141                	addi	sp,sp,-16
    8000685e:	e422                	sd	s0,8(sp)
    80006860:	0800                	addi	s0,sp,16
  uint64 val;
  __atomic_load(addr, &val, __ATOMIC_SEQ_CST);
    80006862:	0ff0000f          	fence
    80006866:	6108                	ld	a0,0(a0)
    80006868:	0ff0000f          	fence
  return val;
}
    8000686c:	6422                	ld	s0,8(sp)
    8000686e:	0141                	addi	sp,sp,16
    80006870:	8082                	ret

0000000080006872 <lockfree_read4>:

// Read a shared 32-bit value without holding a lock
int
lockfree_read4(int *addr) {
    80006872:	1141                	addi	sp,sp,-16
    80006874:	e422                	sd	s0,8(sp)
    80006876:	0800                	addi	s0,sp,16
  uint32 val;
  __atomic_load(addr, &val, __ATOMIC_SEQ_CST);
    80006878:	0ff0000f          	fence
    8000687c:	4108                	lw	a0,0(a0)
    8000687e:	0ff0000f          	fence
  return val;
}
    80006882:	2501                	sext.w	a0,a0
    80006884:	6422                	ld	s0,8(sp)
    80006886:	0141                	addi	sp,sp,16
    80006888:	8082                	ret

000000008000688a <snprint_lock>:
#ifdef LAB_LOCK
int
snprint_lock(char *buf, int sz, struct spinlock *lk)
{
  int n = 0;
  if(lk->n > 0) {
    8000688a:	4e5c                	lw	a5,28(a2)
    8000688c:	00f04463          	bgtz	a5,80006894 <snprint_lock+0xa>
  int n = 0;
    80006890:	4501                	li	a0,0
    n = snprintf(buf, sz, "lock: %s: #test-and-set %d #acquire() %d\n",
                 lk->name, lk->nts, lk->n);
  }
  return n;
}
    80006892:	8082                	ret
{
    80006894:	1141                	addi	sp,sp,-16
    80006896:	e406                	sd	ra,8(sp)
    80006898:	e022                	sd	s0,0(sp)
    8000689a:	0800                	addi	s0,sp,16
    n = snprintf(buf, sz, "lock: %s: #test-and-set %d #acquire() %d\n",
    8000689c:	4e18                	lw	a4,24(a2)
    8000689e:	6614                	ld	a3,8(a2)
    800068a0:	00002617          	auipc	a2,0x2
    800068a4:	fa060613          	addi	a2,a2,-96 # 80008840 <digits+0x60>
    800068a8:	fffff097          	auipc	ra,0xfffff
    800068ac:	1ea080e7          	jalr	490(ra) # 80005a92 <snprintf>
}
    800068b0:	60a2                	ld	ra,8(sp)
    800068b2:	6402                	ld	s0,0(sp)
    800068b4:	0141                	addi	sp,sp,16
    800068b6:	8082                	ret

00000000800068b8 <statslock>:

int
statslock(char *buf, int sz) {
    800068b8:	7159                	addi	sp,sp,-112
    800068ba:	f486                	sd	ra,104(sp)
    800068bc:	f0a2                	sd	s0,96(sp)
    800068be:	eca6                	sd	s1,88(sp)
    800068c0:	e8ca                	sd	s2,80(sp)
    800068c2:	e4ce                	sd	s3,72(sp)
    800068c4:	e0d2                	sd	s4,64(sp)
    800068c6:	fc56                	sd	s5,56(sp)
    800068c8:	f85a                	sd	s6,48(sp)
    800068ca:	f45e                	sd	s7,40(sp)
    800068cc:	f062                	sd	s8,32(sp)
    800068ce:	ec66                	sd	s9,24(sp)
    800068d0:	e86a                	sd	s10,16(sp)
    800068d2:	e46e                	sd	s11,8(sp)
    800068d4:	1880                	addi	s0,sp,112
    800068d6:	8aaa                	mv	s5,a0
    800068d8:	8b2e                	mv	s6,a1
  int n;
  int tot = 0;

  acquire(&lock_locks);
    800068da:	00024517          	auipc	a0,0x24
    800068de:	9ae50513          	addi	a0,a0,-1618 # 8002a288 <lock_locks>
    800068e2:	00000097          	auipc	ra,0x0
    800068e6:	d7e080e7          	jalr	-642(ra) # 80006660 <acquire>
  n = snprintf(buf, sz, "--- lock kmem/bcache stats\n");
    800068ea:	00002617          	auipc	a2,0x2
    800068ee:	f8660613          	addi	a2,a2,-122 # 80008870 <digits+0x90>
    800068f2:	85da                	mv	a1,s6
    800068f4:	8556                	mv	a0,s5
    800068f6:	fffff097          	auipc	ra,0xfffff
    800068fa:	19c080e7          	jalr	412(ra) # 80005a92 <snprintf>
    800068fe:	892a                	mv	s2,a0
  for(int i = 0; i < NLOCK; i++) {
    80006900:	00024c97          	auipc	s9,0x24
    80006904:	9a8c8c93          	addi	s9,s9,-1624 # 8002a2a8 <locks>
    80006908:	00025c17          	auipc	s8,0x25
    8000690c:	940c0c13          	addi	s8,s8,-1728 # 8002b248 <end>
  n = snprintf(buf, sz, "--- lock kmem/bcache stats\n");
    80006910:	84e6                	mv	s1,s9
  int tot = 0;
    80006912:	4a01                	li	s4,0
    if(locks[i] == 0)
      break;
    if(strncmp(locks[i]->name, "bcache", strlen("bcache")) == 0 ||
    80006914:	00002b97          	auipc	s7,0x2
    80006918:	b64b8b93          	addi	s7,s7,-1180 # 80008478 <syscalls+0xb0>
       strncmp(locks[i]->name, "kmem", strlen("kmem")) == 0) {
    8000691c:	00001d17          	auipc	s10,0x1
    80006920:	6fcd0d13          	addi	s10,s10,1788 # 80008018 <etext+0x18>
    80006924:	a01d                	j	8000694a <statslock+0x92>
      tot += locks[i]->nts;
    80006926:	0009b603          	ld	a2,0(s3)
    8000692a:	4e1c                	lw	a5,24(a2)
    8000692c:	01478a3b          	addw	s4,a5,s4
      n += snprint_lock(buf +n, sz-n, locks[i]);
    80006930:	412b05bb          	subw	a1,s6,s2
    80006934:	012a8533          	add	a0,s5,s2
    80006938:	00000097          	auipc	ra,0x0
    8000693c:	f52080e7          	jalr	-174(ra) # 8000688a <snprint_lock>
    80006940:	0125093b          	addw	s2,a0,s2
  for(int i = 0; i < NLOCK; i++) {
    80006944:	04a1                	addi	s1,s1,8
    80006946:	05848763          	beq	s1,s8,80006994 <statslock+0xdc>
    if(locks[i] == 0)
    8000694a:	89a6                	mv	s3,s1
    8000694c:	609c                	ld	a5,0(s1)
    8000694e:	c3b9                	beqz	a5,80006994 <statslock+0xdc>
    if(strncmp(locks[i]->name, "bcache", strlen("bcache")) == 0 ||
    80006950:	0087bd83          	ld	s11,8(a5)
    80006954:	855e                	mv	a0,s7
    80006956:	ffffa097          	auipc	ra,0xffffa
    8000695a:	a84080e7          	jalr	-1404(ra) # 800003da <strlen>
    8000695e:	0005061b          	sext.w	a2,a0
    80006962:	85de                	mv	a1,s7
    80006964:	856e                	mv	a0,s11
    80006966:	ffffa097          	auipc	ra,0xffffa
    8000696a:	9c8080e7          	jalr	-1592(ra) # 8000032e <strncmp>
    8000696e:	dd45                	beqz	a0,80006926 <statslock+0x6e>
       strncmp(locks[i]->name, "kmem", strlen("kmem")) == 0) {
    80006970:	609c                	ld	a5,0(s1)
    80006972:	0087bd83          	ld	s11,8(a5)
    80006976:	856a                	mv	a0,s10
    80006978:	ffffa097          	auipc	ra,0xffffa
    8000697c:	a62080e7          	jalr	-1438(ra) # 800003da <strlen>
    80006980:	0005061b          	sext.w	a2,a0
    80006984:	85ea                	mv	a1,s10
    80006986:	856e                	mv	a0,s11
    80006988:	ffffa097          	auipc	ra,0xffffa
    8000698c:	9a6080e7          	jalr	-1626(ra) # 8000032e <strncmp>
    if(strncmp(locks[i]->name, "bcache", strlen("bcache")) == 0 ||
    80006990:	f955                	bnez	a0,80006944 <statslock+0x8c>
    80006992:	bf51                	j	80006926 <statslock+0x6e>
    }
  }
  
  n += snprintf(buf+n, sz-n, "--- top 5 contended locks:\n");
    80006994:	00002617          	auipc	a2,0x2
    80006998:	efc60613          	addi	a2,a2,-260 # 80008890 <digits+0xb0>
    8000699c:	412b05bb          	subw	a1,s6,s2
    800069a0:	012a8533          	add	a0,s5,s2
    800069a4:	fffff097          	auipc	ra,0xfffff
    800069a8:	0ee080e7          	jalr	238(ra) # 80005a92 <snprintf>
    800069ac:	012509bb          	addw	s3,a0,s2
    800069b0:	4b95                	li	s7,5
  int last = 100000000;
    800069b2:	05f5e537          	lui	a0,0x5f5e
    800069b6:	10050513          	addi	a0,a0,256 # 5f5e100 <_entry-0x7a0a1f00>
  // stupid way to compute top 5 contended locks
  for(int t = 0; t < 5; t++) {
    int top = 0;
    for(int i = 0; i < NLOCK; i++) {
    800069ba:	4c01                	li	s8,0
      if(locks[i] == 0)
        break;
      if(locks[i]->nts > locks[top]->nts && locks[i]->nts < last) {
    800069bc:	00024497          	auipc	s1,0x24
    800069c0:	8ec48493          	addi	s1,s1,-1812 # 8002a2a8 <locks>
    for(int i = 0; i < NLOCK; i++) {
    800069c4:	1f400913          	li	s2,500
    800069c8:	a881                	j	80006a18 <statslock+0x160>
    800069ca:	2705                	addiw	a4,a4,1
    800069cc:	06a1                	addi	a3,a3,8
    800069ce:	03270063          	beq	a4,s2,800069ee <statslock+0x136>
      if(locks[i] == 0)
    800069d2:	629c                	ld	a5,0(a3)
    800069d4:	cf89                	beqz	a5,800069ee <statslock+0x136>
      if(locks[i]->nts > locks[top]->nts && locks[i]->nts < last) {
    800069d6:	4f90                	lw	a2,24(a5)
    800069d8:	00359793          	slli	a5,a1,0x3
    800069dc:	97a6                	add	a5,a5,s1
    800069de:	639c                	ld	a5,0(a5)
    800069e0:	4f9c                	lw	a5,24(a5)
    800069e2:	fec7d4e3          	bge	a5,a2,800069ca <statslock+0x112>
    800069e6:	fea652e3          	bge	a2,a0,800069ca <statslock+0x112>
    800069ea:	85ba                	mv	a1,a4
    800069ec:	bff9                	j	800069ca <statslock+0x112>
        top = i;
      }
    }
    n += snprint_lock(buf+n, sz-n, locks[top]);
    800069ee:	058e                	slli	a1,a1,0x3
    800069f0:	00b48d33          	add	s10,s1,a1
    800069f4:	000d3603          	ld	a2,0(s10)
    800069f8:	413b05bb          	subw	a1,s6,s3
    800069fc:	013a8533          	add	a0,s5,s3
    80006a00:	00000097          	auipc	ra,0x0
    80006a04:	e8a080e7          	jalr	-374(ra) # 8000688a <snprint_lock>
    80006a08:	013509bb          	addw	s3,a0,s3
    last = locks[top]->nts;
    80006a0c:	000d3783          	ld	a5,0(s10)
    80006a10:	4f88                	lw	a0,24(a5)
  for(int t = 0; t < 5; t++) {
    80006a12:	3bfd                	addiw	s7,s7,-1
    80006a14:	000b8663          	beqz	s7,80006a20 <statslock+0x168>
  int tot = 0;
    80006a18:	86e6                	mv	a3,s9
    for(int i = 0; i < NLOCK; i++) {
    80006a1a:	8762                	mv	a4,s8
    int top = 0;
    80006a1c:	85e2                	mv	a1,s8
    80006a1e:	bf55                	j	800069d2 <statslock+0x11a>
  }
  n += snprintf(buf+n, sz-n, "tot= %d\n", tot);
    80006a20:	86d2                	mv	a3,s4
    80006a22:	00002617          	auipc	a2,0x2
    80006a26:	e8e60613          	addi	a2,a2,-370 # 800088b0 <digits+0xd0>
    80006a2a:	413b05bb          	subw	a1,s6,s3
    80006a2e:	013a8533          	add	a0,s5,s3
    80006a32:	fffff097          	auipc	ra,0xfffff
    80006a36:	060080e7          	jalr	96(ra) # 80005a92 <snprintf>
    80006a3a:	013509bb          	addw	s3,a0,s3
  release(&lock_locks);  
    80006a3e:	00024517          	auipc	a0,0x24
    80006a42:	84a50513          	addi	a0,a0,-1974 # 8002a288 <lock_locks>
    80006a46:	00000097          	auipc	ra,0x0
    80006a4a:	cea080e7          	jalr	-790(ra) # 80006730 <release>
  return n;
}
    80006a4e:	854e                	mv	a0,s3
    80006a50:	70a6                	ld	ra,104(sp)
    80006a52:	7406                	ld	s0,96(sp)
    80006a54:	64e6                	ld	s1,88(sp)
    80006a56:	6946                	ld	s2,80(sp)
    80006a58:	69a6                	ld	s3,72(sp)
    80006a5a:	6a06                	ld	s4,64(sp)
    80006a5c:	7ae2                	ld	s5,56(sp)
    80006a5e:	7b42                	ld	s6,48(sp)
    80006a60:	7ba2                	ld	s7,40(sp)
    80006a62:	7c02                	ld	s8,32(sp)
    80006a64:	6ce2                	ld	s9,24(sp)
    80006a66:	6d42                	ld	s10,16(sp)
    80006a68:	6da2                	ld	s11,8(sp)
    80006a6a:	6165                	addi	sp,sp,112
    80006a6c:	8082                	ret
	...

0000000080007000 <_trampoline>:
    80007000:	14051573          	csrrw	a0,sscratch,a0
    80007004:	02153423          	sd	ra,40(a0)
    80007008:	02253823          	sd	sp,48(a0)
    8000700c:	02353c23          	sd	gp,56(a0)
    80007010:	04453023          	sd	tp,64(a0)
    80007014:	04553423          	sd	t0,72(a0)
    80007018:	04653823          	sd	t1,80(a0)
    8000701c:	04753c23          	sd	t2,88(a0)
    80007020:	f120                	sd	s0,96(a0)
    80007022:	f524                	sd	s1,104(a0)
    80007024:	fd2c                	sd	a1,120(a0)
    80007026:	e150                	sd	a2,128(a0)
    80007028:	e554                	sd	a3,136(a0)
    8000702a:	e958                	sd	a4,144(a0)
    8000702c:	ed5c                	sd	a5,152(a0)
    8000702e:	0b053023          	sd	a6,160(a0)
    80007032:	0b153423          	sd	a7,168(a0)
    80007036:	0b253823          	sd	s2,176(a0)
    8000703a:	0b353c23          	sd	s3,184(a0)
    8000703e:	0d453023          	sd	s4,192(a0)
    80007042:	0d553423          	sd	s5,200(a0)
    80007046:	0d653823          	sd	s6,208(a0)
    8000704a:	0d753c23          	sd	s7,216(a0)
    8000704e:	0f853023          	sd	s8,224(a0)
    80007052:	0f953423          	sd	s9,232(a0)
    80007056:	0fa53823          	sd	s10,240(a0)
    8000705a:	0fb53c23          	sd	s11,248(a0)
    8000705e:	11c53023          	sd	t3,256(a0)
    80007062:	11d53423          	sd	t4,264(a0)
    80007066:	11e53823          	sd	t5,272(a0)
    8000706a:	11f53c23          	sd	t6,280(a0)
    8000706e:	140022f3          	csrr	t0,sscratch
    80007072:	06553823          	sd	t0,112(a0)
    80007076:	00853103          	ld	sp,8(a0)
    8000707a:	02053203          	ld	tp,32(a0)
    8000707e:	01053283          	ld	t0,16(a0)
    80007082:	00053303          	ld	t1,0(a0)
    80007086:	18031073          	csrw	satp,t1
    8000708a:	12000073          	sfence.vma
    8000708e:	8282                	jr	t0

0000000080007090 <userret>:
    80007090:	18059073          	csrw	satp,a1
    80007094:	12000073          	sfence.vma
    80007098:	07053283          	ld	t0,112(a0)
    8000709c:	14029073          	csrw	sscratch,t0
    800070a0:	02853083          	ld	ra,40(a0)
    800070a4:	03053103          	ld	sp,48(a0)
    800070a8:	03853183          	ld	gp,56(a0)
    800070ac:	04053203          	ld	tp,64(a0)
    800070b0:	04853283          	ld	t0,72(a0)
    800070b4:	05053303          	ld	t1,80(a0)
    800070b8:	05853383          	ld	t2,88(a0)
    800070bc:	7120                	ld	s0,96(a0)
    800070be:	7524                	ld	s1,104(a0)
    800070c0:	7d2c                	ld	a1,120(a0)
    800070c2:	6150                	ld	a2,128(a0)
    800070c4:	6554                	ld	a3,136(a0)
    800070c6:	6958                	ld	a4,144(a0)
    800070c8:	6d5c                	ld	a5,152(a0)
    800070ca:	0a053803          	ld	a6,160(a0)
    800070ce:	0a853883          	ld	a7,168(a0)
    800070d2:	0b053903          	ld	s2,176(a0)
    800070d6:	0b853983          	ld	s3,184(a0)
    800070da:	0c053a03          	ld	s4,192(a0)
    800070de:	0c853a83          	ld	s5,200(a0)
    800070e2:	0d053b03          	ld	s6,208(a0)
    800070e6:	0d853b83          	ld	s7,216(a0)
    800070ea:	0e053c03          	ld	s8,224(a0)
    800070ee:	0e853c83          	ld	s9,232(a0)
    800070f2:	0f053d03          	ld	s10,240(a0)
    800070f6:	0f853d83          	ld	s11,248(a0)
    800070fa:	10053e03          	ld	t3,256(a0)
    800070fe:	10853e83          	ld	t4,264(a0)
    80007102:	11053f03          	ld	t5,272(a0)
    80007106:	11853f83          	ld	t6,280(a0)
    8000710a:	14051573          	csrrw	a0,sscratch,a0
    8000710e:	10200073          	sret
	...
