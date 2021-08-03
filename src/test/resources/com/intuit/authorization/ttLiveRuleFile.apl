package: com.intuit.authorization

rule: CustomerAccessTTLFirmData_v1
description: Customer can access data created by the customer but owned by the TTL firm,Customer access data created on behalf of the customer
salience: 1
when:
  - sub["nsId"] == "50000003"
  - res[ownerId] == "13563577577860279" || res[ownerId]=="13563577446165049" || res[ownerId]=="13633951204877602"
  - res["id"] == "Intuit.ttlive.test.app_id"
  - containsAnyIgnoreCase({"firm-docs-public", "tax-docs"} , res["idp.metaTags"])
  - isAttrSet("sub","nsId")
  - T(java.lang.Math).abs(-5)== 5
  - sub["id"]==attrFirst('res', 'onBehalfOf')
  - containsAny({"firm-docs-public", "tax-docs"} , res["idp.metaTags"])
  - action["id"] == "us.tax.adm"

then:
  - decision=permit
  - |-
          newObligation()
          .put("decision", "permit")
          .put("role", "PG.consumer.tax.idp.read")
          .put("role", "PG.consumer.tax.idp.write")
          .put("role", "request.organizer.read")

---

rule: CustomerAccessTTLFirmData_v2
description: Customer can access data created by the customer but owned by the TTL firm,Customer access data created on behalf of the customer
salience: 1
when:
  - sub["nsId"] == "50000003"
  - res[ownerId] == "13563577577860279" || res[ownerId]=="13563577446165049" || res[ownerId]=="13633951204877602"
  - res["id"] == "Intuit.ttlive.test.app_id"
  - containsAnyIgnoreCase({"firm-docs-public", "tax-docs"} , res["idp.metaTags"])
  - isAttrSet("sub","nsId")
  - T(java.lang.Math).abs(-5)== 5
  - sub["id"]==attrFirst('res', 'onBehalfOf')
  - containsAny({"firm-docs-public", "tax-docs"} , res["idp.metaTags"])
  - action["id"] == "us.tax.exp"

then:
  - decision=permit
  - |-
          newObligation()
          .put("decision", "permit")
          .put("role", "PG.consumer.tax.idp.read")
          .put("role", "PG.consumer.tax.idp.write")
          .put("role", "request.organizer.read")


---

rule: Default Rule
description: default rule execution
salience: 0
when:
then:
  - decision=deny
  - |-
          newObligation()
          .put("rule", "CustomerAccessTTLFirmData_v1")
          .put("decision", "deny")



