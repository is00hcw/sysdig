--[[
Copyright (C) 2013-2014 Draios inc.
 
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License version 2 as
published by the Free Software Foundation.


This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
--]]

view_info = 
{
	id = "kubernetes_controllers",
	name = "K8s Controllers",
	description = "List all Kubernetes controllers running on this machine, and the resources that each of them uses.",
	tips = {"Select a controller and click enter to drill down into it. At that point, you will be able to access several views that will show you the details of the selected controller."},
	view_type = "table",
	applies_to = {"", "evt.res", "k8s.pod.id", "k8s.svc.id", "k8s.ns.id"},
	filter = "k8s.rc.id != ''",
	use_defaults = true,
	drilldown_target = "kubernetes_pods",
	columns = 
	{
		{
			name = "NA",
			field = "thread.tid",
			is_key = true
		},
		{
			name = "CPU",
			field = "thread.cpu",
			description = "Amount of CPU used by the controller.",
			colsize = 8,
			aggregation = "AVG",
			groupby_aggregation = "SUM",
			is_sorting = true
		},
		{
			name = "VIRT",
			field = "thread.vmsize",
			description = "total virtual memory for the controller (as kb).",
			aggregation = "MAX",
			groupby_aggregation = "SUM",
			colsize = 9
		},
		{
			name = "RES",
			field = "thread.vmrss",
			description = "resident non-swapped memory for the controller (as kb).",
			aggregation = "MAX",
			groupby_aggregation = "SUM",
			colsize = 9
		},
		{
			name = "FILE",
			field = "evt.buflen.file",
			description = "Total (input+output) file I/O bandwidth generated by the controller, in bytes per second.",
			colsize = 8,
			aggregation = "TIME_AVG",
			groupby_aggregation = "SUM"
		},
		{
			name = "NET",
			field = "evt.buflen.net",
			description = "Total (input+output) network bandwidth generated by the controller, in bytes per second.",
			colsize = 8,
			aggregation = "TIME_AVG",
			groupby_aggregation = "SUM"
		},
		{
			name = "NA",
			field = "k8s.rc.id",
			is_groupby_key = true
		},
		{
			name = "ID",
			field = "k8s.rc.id",
			description = "Controller id.",
			colsize = 38
		},
		{
			name = "NAME",
			field = "k8s.rc.name",
			description = "Controller name.",
			colsize = 25
		},
		{
			name = "NAMESPACE",
			field = "k8s.ns.name",
			description = "Controller namespace.",
			colsize = 20
		},
		{
			name = "LABELS",
			field = "k8s.rc.labels",
			description = "Controller labels.",
			colsize = 0
		},
	},
	actions = 
	{
		{
			hotkey = "d",
			command = "kubectl --namespace=%k8s.ns.name describe rc %k8s.rc.name",
			description = "describe"
		},
		{
			hotkey = "x",
			command = "kubectl --namespace=%k8s.ns.name delete rc %k8s.rc.name",
			description = "delete"
		}
	}
}