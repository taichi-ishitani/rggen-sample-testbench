//------------------------------------------------------------------------------
//  Copyright 2017 Taichi Ishitani
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//------------------------------------------------------------------------------
`ifndef TUE_REACTIVE_SEQUENCE_SVH
`define TUE_REACTIVE_SEQUENCE_SVH
virtual class tue_reactive_sequence #(
  type  CONFIGURATION = tue_configuration_dummy,
  type  STATUS        = tue_status_dummy,
  type  ITEM          = uvm_sequence_item,
  type  REQUEST       = ITEM,
  type  RSP           = ITEM
) extends tue_sequence #(CONFIGURATION, STATUS, ITEM, RSP);
  typedef tue_reactive_sequencer #(CONFIGURATION, STATUS, ITEM, REQUEST, RSP) t_sequencer;

  virtual task get_request(ref REQUEST request);
    t_sequencer sequencer;
    if ($cast(sequencer, get_sequencer())) begin
      sequencer.get_request(request);
    end
    else begin
      `uvm_fatal(get_name(), "Error casting reactive sequencer")
    end
  endtask

  `tue_object_default_constructor(tue_reactive_sequence)
endclass
`endif
