#!/bin/bash

ip rule add fwmark 0x2 table lab-mesh
