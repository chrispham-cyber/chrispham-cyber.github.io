---
layout: post
title:  "Juggling Facts"
date:   2025-04-10 16:40:00 -0400
categories: HTB-challenge web very-easy
tags: HTB CTF writeup php
---

### SOLUTION
By analyzing the code, we can see this.
```
  public function getfacts($router)
    {
        $jsondata = json_decode(file_get_contents('php://input'), true);

        if ( empty($jsondata) || !array_key_exists('type', $jsondata))
        {
            return $router->jsonify(['message' => 'Insufficient parameters!']);
        }

        if ($jsondata['type'] === 'secrets' && $_SERVER['REMOTE_ADDR'] !== '127.0.0.1')
        {
            return $router->jsonify(['message' => 'Currently this type can be only accessed through localhost!']);
        }

        switch ($jsondata['type'])
        {
            case 'secrets':
                return $router->jsonify([
                    'facts' => $this->facts->get_facts('secrets')
                ]);

            case 'spooky':
                return $router->jsonify([
                    'facts' => $this->facts->get_facts('spooky')
                ]);
            
            case 'not_spooky':
                return $router->jsonify([
                    'facts' => $this->facts->get_facts('not_spooky')
                ]);
            
            default:
                return $router->jsonify([
                    'message' => 'Invalid type!'
                ]);
        }

```

Search for `PHP switch`, we know that PHP switch statement performs loose comparison.
![](assets/img/htb/juggling facts/1.png)

Change our type to `true`
![](assets/img/htb/juggling facts/2.png)
