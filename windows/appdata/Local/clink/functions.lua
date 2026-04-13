function vifm(rl_buffer)
    rl_buffer:remove(0, rl_buffer:getlength() + 1)
    rl_buffer:insert('vifm')
    rl.invokecommand('accept-line')
end

function quit(rl_buffer)
    rl_buffer:remove(0, rl_buffer:getlength() + 1)
    rl_buffer:insert('exit')
    rl.invokecommand('accept-line')
end
