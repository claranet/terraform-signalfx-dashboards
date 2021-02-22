HOSTS = data('sf.org.child.numResourcesMonitored').sum(by=['childOrgId', 'childOrgName'])${aggregation}.publish(label='HOSTS', enable=${publish["HOSTS"]})
MTS = data('sf.org.child.numCustomMetrics').sum(by=['childOrgId', 'childOrgName'])${aggregation}.publish(label='MTS', enable=${publish["MTS"]})
